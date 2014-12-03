##
## Auto Generated makefile by CodeLite IDE
## any manual changes will be erased      
##
## Debug
ProjectName            :=Master_Server
ConfigurationName      :=Debug
IntermediateDirectory  :=./Debug
OutDir                 := $(IntermediateDirectory)
WorkspacePath          := "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/repeater_server"
ProjectPath            := "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server"
CurrentFileName        :=
CurrentFilePath        :=
CurrentFileFullPath    :=
User                   :=wim
Date                   :=08-09-14
CodeLitePath           :="/home/wim/.codelite"
LinkerName             :=gcc
ArchiveTool            :=ar rcus
SharedObjectLinkerName :=gcc -shared -fPIC
ObjectSuffix           :=.o
DependSuffix           :=.o.d
PreprocessSuffix       :=.o.i
DebugSwitch            :=-g 
IncludeSwitch          :=-I
LibrarySwitch          :=-l
OutputSwitch           :=-o 
LibraryPathSwitch      :=-L
PreprocessorSwitch     :=-D
SourceSwitch           :=-c 
CompilerName           :=gcc
C_CompilerName         :=gcc
OutputFile             :=$(IntermediateDirectory)/$(ProjectName)
Preprocessors          :=
ObjectSwitch           :=-o 
ArchiveOutputSwitch    := 
PreprocessOnlySwitch   :=-E 
MakeDirCommand         :=mkdir -p
CmpOptions             := -g $(Preprocessors)
LinkOptions            :=  
IncludePath            :=  "$(IncludeSwitch)." "$(IncludeSwitch)." 
RcIncludePath          :=
Libs                   :=$(LibrarySwitch)pthread $(LibrarySwitch)sqlite3 $(LibrarySwitch)m 
LibPath                := "$(LibraryPathSwitch)." 


##
## User defined environment variables
##
CodeLiteDir:=/usr/share/codelite
Objects=$(IntermediateDirectory)/dmr$(ObjectSuffix) $(IntermediateDirectory)/sqlite$(ObjectSuffix) $(IntermediateDirectory)/smaster$(ObjectSuffix) $(IntermediateDirectory)/rdac$(ObjectSuffix) $(IntermediateDirectory)/main$(ObjectSuffix) $(IntermediateDirectory)/convbin$(ObjectSuffix) $(IntermediateDirectory)/BPTC1969$(ObjectSuffix) \
	$(IntermediateDirectory)/aprs$(ObjectSuffix) $(IntermediateDirectory)/decode34Rate$(ObjectSuffix) $(IntermediateDirectory)/hyteraDecode$(ObjectSuffix) $(IntermediateDirectory)/scheduler$(ObjectSuffix) 

##
## Main Build Targets 
##
all: $(OutputFile)

$(OutputFile): makeDirStep $(Objects)
	@$(MakeDirCommand) $(@D)
	$(LinkerName) $(OutputSwitch)$(OutputFile) $(Objects) $(LibPath) $(Libs) $(LinkOptions)

makeDirStep:
	@test -d ./Debug || $(MakeDirCommand) ./Debug

PreBuild:


##
## Objects
##
$(IntermediateDirectory)/dmr$(ObjectSuffix): dmr.c $(IntermediateDirectory)/dmr$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/dmr.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/dmr$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/dmr$(DependSuffix): dmr.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/dmr$(ObjectSuffix) -MF$(IntermediateDirectory)/dmr$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/dmr.c"

$(IntermediateDirectory)/dmr$(PreprocessSuffix): dmr.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/dmr$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/dmr.c"

$(IntermediateDirectory)/sqlite$(ObjectSuffix): sqlite.c $(IntermediateDirectory)/sqlite$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/sqlite.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/sqlite$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/sqlite$(DependSuffix): sqlite.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/sqlite$(ObjectSuffix) -MF$(IntermediateDirectory)/sqlite$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/sqlite.c"

$(IntermediateDirectory)/sqlite$(PreprocessSuffix): sqlite.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/sqlite$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/sqlite.c"

$(IntermediateDirectory)/smaster$(ObjectSuffix): smaster.c $(IntermediateDirectory)/smaster$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/smaster.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/smaster$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/smaster$(DependSuffix): smaster.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/smaster$(ObjectSuffix) -MF$(IntermediateDirectory)/smaster$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/smaster.c"

$(IntermediateDirectory)/smaster$(PreprocessSuffix): smaster.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/smaster$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/smaster.c"

$(IntermediateDirectory)/rdac$(ObjectSuffix): rdac.c $(IntermediateDirectory)/rdac$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/rdac.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/rdac$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/rdac$(DependSuffix): rdac.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/rdac$(ObjectSuffix) -MF$(IntermediateDirectory)/rdac$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/rdac.c"

$(IntermediateDirectory)/rdac$(PreprocessSuffix): rdac.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/rdac$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/rdac.c"

$(IntermediateDirectory)/main$(ObjectSuffix): main.c $(IntermediateDirectory)/main$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/main.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/main$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/main$(DependSuffix): main.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/main$(ObjectSuffix) -MF$(IntermediateDirectory)/main$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/main.c"

$(IntermediateDirectory)/main$(PreprocessSuffix): main.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/main$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/main.c"

$(IntermediateDirectory)/convbin$(ObjectSuffix): convbin.c $(IntermediateDirectory)/convbin$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/convbin.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/convbin$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/convbin$(DependSuffix): convbin.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/convbin$(ObjectSuffix) -MF$(IntermediateDirectory)/convbin$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/convbin.c"

$(IntermediateDirectory)/convbin$(PreprocessSuffix): convbin.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/convbin$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/convbin.c"

$(IntermediateDirectory)/BPTC1969$(ObjectSuffix): BPTC1969.c $(IntermediateDirectory)/BPTC1969$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/BPTC1969.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/BPTC1969$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/BPTC1969$(DependSuffix): BPTC1969.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/BPTC1969$(ObjectSuffix) -MF$(IntermediateDirectory)/BPTC1969$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/BPTC1969.c"

$(IntermediateDirectory)/BPTC1969$(PreprocessSuffix): BPTC1969.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/BPTC1969$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/BPTC1969.c"

$(IntermediateDirectory)/aprs$(ObjectSuffix): aprs.c $(IntermediateDirectory)/aprs$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/aprs.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/aprs$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/aprs$(DependSuffix): aprs.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/aprs$(ObjectSuffix) -MF$(IntermediateDirectory)/aprs$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/aprs.c"

$(IntermediateDirectory)/aprs$(PreprocessSuffix): aprs.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/aprs$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/aprs.c"

$(IntermediateDirectory)/decode34Rate$(ObjectSuffix): decode34Rate.c $(IntermediateDirectory)/decode34Rate$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/decode34Rate.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/decode34Rate$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/decode34Rate$(DependSuffix): decode34Rate.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/decode34Rate$(ObjectSuffix) -MF$(IntermediateDirectory)/decode34Rate$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/decode34Rate.c"

$(IntermediateDirectory)/decode34Rate$(PreprocessSuffix): decode34Rate.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/decode34Rate$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/decode34Rate.c"

$(IntermediateDirectory)/hyteraDecode$(ObjectSuffix): hyteraDecode.c $(IntermediateDirectory)/hyteraDecode$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/hyteraDecode.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/hyteraDecode$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/hyteraDecode$(DependSuffix): hyteraDecode.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/hyteraDecode$(ObjectSuffix) -MF$(IntermediateDirectory)/hyteraDecode$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/hyteraDecode.c"

$(IntermediateDirectory)/hyteraDecode$(PreprocessSuffix): hyteraDecode.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/hyteraDecode$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/hyteraDecode.c"

$(IntermediateDirectory)/scheduler$(ObjectSuffix): scheduler.c $(IntermediateDirectory)/scheduler$(DependSuffix)
	$(C_CompilerName) $(SourceSwitch) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/scheduler.c" $(CmpOptions) $(ObjectSwitch)$(IntermediateDirectory)/scheduler$(ObjectSuffix) $(IncludePath)
$(IntermediateDirectory)/scheduler$(DependSuffix): scheduler.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) -MT$(IntermediateDirectory)/scheduler$(ObjectSuffix) -MF$(IntermediateDirectory)/scheduler$(DependSuffix) -MM "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/scheduler.c"

$(IntermediateDirectory)/scheduler$(PreprocessSuffix): scheduler.c
	@$(C_CompilerName) $(CmpOptions) $(IncludePath) $(PreprocessOnlySwitch) $(OutputSwitch) $(IntermediateDirectory)/scheduler$(PreprocessSuffix) "/home/wim/.gvfs/documents op nas8d5dcf/Projects/DMR/Master_Server/scheduler.c"


-include $(IntermediateDirectory)/*$(DependSuffix)
##
## Clean
##
clean:
	$(RM) $(IntermediateDirectory)/dmr$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/dmr$(DependSuffix)
	$(RM) $(IntermediateDirectory)/dmr$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/sqlite$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/sqlite$(DependSuffix)
	$(RM) $(IntermediateDirectory)/sqlite$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/smaster$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/smaster$(DependSuffix)
	$(RM) $(IntermediateDirectory)/smaster$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/rdac$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/rdac$(DependSuffix)
	$(RM) $(IntermediateDirectory)/rdac$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/main$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/main$(DependSuffix)
	$(RM) $(IntermediateDirectory)/main$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/convbin$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/convbin$(DependSuffix)
	$(RM) $(IntermediateDirectory)/convbin$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/BPTC1969$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/BPTC1969$(DependSuffix)
	$(RM) $(IntermediateDirectory)/BPTC1969$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/aprs$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/aprs$(DependSuffix)
	$(RM) $(IntermediateDirectory)/aprs$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/decode34Rate$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/decode34Rate$(DependSuffix)
	$(RM) $(IntermediateDirectory)/decode34Rate$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/hyteraDecode$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/hyteraDecode$(DependSuffix)
	$(RM) $(IntermediateDirectory)/hyteraDecode$(PreprocessSuffix)
	$(RM) $(IntermediateDirectory)/scheduler$(ObjectSuffix)
	$(RM) $(IntermediateDirectory)/scheduler$(DependSuffix)
	$(RM) $(IntermediateDirectory)/scheduler$(PreprocessSuffix)
	$(RM) $(OutputFile)


