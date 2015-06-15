<?php
//
//DmrMarcRip.php - utility to Download the DMR-MARC DMR database
//Copyright (C) 2012 David Kierzokwski (kd8eyf@digitalham.info)
//
//This program is free software; you can redistribute it and/or
//modify it under the terms of the GNU General Public License
//as published by the Free Software Foundation; either version 2
//of the License, or (at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//GNU General Public License for more details.
//
//You should have received a copy of the GNU General Public License
//along with this program; if not, write to the Free Software
//Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
//----------------------------------CHANGE THESE--------------------------------------------------------------//
$db  = new SQLite3("Master_Server.sql");
$UserUrl = "http://www.dmr-marc.net/cgi-bin/trbo-database/datadump.cgi?table=users&format=csv&header=0";
$UserFieldNames = array('radioId','callsign','name','city','state','country','homeRepeaterId','remarks');
//----------------------------------DONT CHANGE THESE---------------------------------------------------------//

libxml_use_internal_errors(true); //DONT WARN ABOUT DOM PARSING
date_default_timezone_set('UTC'); //SET TIMEZONE TO UTC
$DateTime = date('Y-m-d H:i:s',time()); //SET DATETIME STAMP TO SQL COMPATABILE
$hostname = exec("hostname -f"); //GET SYSTEM HOSTNAME

$OldUser = Array();

$NewUser = RipData($UserUrl,$UserFieldNames,"Belgium"); //RIP SUBSCRIBER DATA

$OldUser = GetOldData("callsigns",$UserFieldNames); //GET CURRENT SUBSCRIBERS

$AddUser = array_diff_key($NewUser,$OldUser); //CALCULATE WHAT USERS ARE NEW

$DelUser = array_diff_key($OldUser,$NewUser); //CALCULATE WHAT USERS ARE REMOVED

$BothUser = array_intersect_key($NewUser,$OldUser); //CALCULATE WHAT USERS EXISIT IN BOTH


DBAdd($AddUser,"callsigns"); //INSERT ADDITIONS TO SUBSCRIBER TABLE

DBChange($OldUser,$NewUser,$BothUser,"callsigns"); //MAKE CHANGED TO SUBSRIBER TABLE

DBRemove($DelUser,"callsigns"); //REMOVE DELETED SUBSCRIBERS FROM TABLE

print "DAILY DMR-MARC DB UPDATE ON: ".$hostname."\n";

function BuildSqlRemove($Array,$Table,$Where) {
     $Query = "DELETE FROM `".$Table."` WHERE ".$Where;
     return ($Query);
}

function BuildSqlInsert($Array,$Table) {
     $Key = array_keys($Array);
     $Value = array_values($Array);
     $Query = "INSERT INTO `".$Table."` (`".implode('`,`',$Key)."`) "."VALUES ('".implode("', '",$Value)."')";
     return ($Query);
}

function BuildSqlUpdate($Array,$Table,$Where) {
     foreach ($Array as $Key => $Value) {
          $Query = $Query."`".$Key."` = '".$Value."', ";
     }
     $Query = trim($Query,", ");
     $Query = "UPDATE `".$Table."` SET ".$Query." WHERE `".$Table."`.".$Where;
     return ($Query);
}

/*function RipData($Url,$ColumnNames,$key) {
     $Dom = new DOMDocument();
     $doctype = DOMImplementation::createDocumentType("html","-//W3C//DTD XHTML 1.1//EN","http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd");
     $Dom->appendChild($doctype);
     $Page = $Dom->loadHTMLFile($Url); //CRAEATE NEW DOM OBJECT
     $Dom->preserveWhiteSpace = false; //DELETE HTML WHITE SPACES
     $Table = $Dom->getElementsByTagName('table'); //IDENTIFY START OF TABLE
     $Rows = $Table->item(0)->getElementsByTagName('tr'); //IDENTIFY ROWS
      foreach ($Rows as $row) { //START A LOOP FOR EACH ROW
          $cols = $row->getElementsByTagName('td'); //GET THE COLUMNS
          if (is_numeric($cols->item($key)->textContent)) { //IS THIS AN ITEM THAT WE WANT TO PROCESS
               $i = 0;
               foreach ($cols as $col) { //LOOP THROUGH EACH COL AND STORE IN ARRAY
                    $array[$cols->item($key)->nodeValue][$ColumnNames[$i]] =str_replace("NBSP","",strtoupper(trim(preg_replace("/[^0-9a-zA-Z .-]/","",$col->textContent))));
                    $i++;
               }
          }
     }
     return $array;
}*/

function RipData($url,$ColumnNames,$filter){
	$data = file_get_contents($url);
	$lines = explode("<BR>\n",$data);
	foreach($lines as $line){
		if(!empty($filter)){
			if(strpos($line,$filter) != 0){
				$cols = explode(",",$line);
				$i = 0;
				foreach($cols as $col){
					$array[$cols[0]][$ColumnNames[$i]] = strtoupper(trim(preg_replace("/[^0-9a-zA-Z .-]/","",$col)));
					$i++;
				}
			}
		}
	}
	return $array;
}
function GetOldData($TableName,$FieldNames) { //GET DATA FROM YESTERDAYS DMR-MARC DATABASE
     global $db;
     $Query = "SELECT * FROM `".$TableName."`;";
     /*$Result = mysql_query($Query) or die("Error in query: $query ".mysql_error());
     $NumResults = mysql_num_rows($Result);
     if ($NumResults > 0) {
          while ($row = mysql_fetch_array($Result,MYSQL_ASSOC)) {
               foreach ($FieldNames as $FieldName) {
                    $array[$row['radioId']][$FieldName] = $row[$FieldName]; //AM I OVERTHINKING THIS?
               }
          }
     }*/
     $result = $db->query($Query);
     while ($row = $result->fetchArray()){
     	foreach ($FieldNames as $FieldName) {
        	$array[$row['radioId']][$FieldName] = $row[$FieldName]; //AM I OVERTHINKING THIS?
        }
     }
     if (is_null($array))
     {
        return array();
     }
        else
     {
        return $array;
     }
}

function DBChange($Old,$New,$Both,$Table){ //CHANGE AN ITEM IN THE DATABASE
     global $db;
     foreach ($Both as $DiffRow) {
          $Diff = array_diff($New[$DiffRow['radioId']],$Old[$DiffRow['radioId']]);
          if ($Diff) {
               $ChangeQuery = BuildSqlUpdate($DiffRow,$Table,"`radioId`='".$DiffRow['radioId']."'")."\n";
               print $Query."\n";
               //mysql_query($ChangeQuery) or die(mysql_error());
               $result = $db->query($ChangeQuery);
               foreach ($Diff as $DifferentItemKey => $DifferentItemVal) {
                    $DiffArray = array('radioId' => $DiffRow['radioId'],'FieldName' => $DifferentItemKey,
                         'OldValue' => $DifferentItemVal,'NewValue' => $Old[$DiffRow['radioId']][$DifferentItemKey]);
                    //LogChange($DiffArray,"CHANGE",$Table);
               }
          }
     }
}
function DBAdd($new,$table) { //ADD A ITEM TO THE DATABASE
     global $db;
     if (count($new) != false) {
          foreach ($new as $AddRow) {
               $Query = BuildSqlInsert($AddRow,$table)."\n";
               $result = $db->query($Query);
               //mysql_query($Query) or die(mysql_error());
               //LogChange($AddRow,"NEW",$table);
          }
     }
}
function DBRemove($del,$table) { //REMOVE A ITEM FROM TEH DATABASE
     global $db;
     if (count($del) != false) {
          foreach ($del as $DelRow) {
               $Where = "`radioId`='".$DelRow['radioId']."'";
               $Query = BuildSqlRemove($DelRow,$table,$Where);
               $result = $db->query($Query);
               //mysql_query($Query) or die(mysql_error());
               //LogChange($DelRow,"DELETE",$table);
          }
     }
}

?>
