
include "llvm/Target/Target.td"

include "HazardRegisterInfo.td"
include "HazardCallingConv.td"
include "HazardSchedule.td"
include "HazardInstrFormats.td"
include "HazardInstrInfo.td"


def HazardInstrInfo : InstrInfo;

def HazardAsmParser : AsmParser {
  let ShouldEmitMatchRegisterName = 0;
}
def HazardAsmParserVariant : AsmParserVariant {
  int Variant = 0;
  let RegisterPrefix = "$";
}
def HazardAsmWriter : AsmWriter;

def Hazard : Target {
  let InstructionSet = HazardInstrInfo;
  let AssemblyParsers = [HazardAsmParser];
  let AssemblyParserVarianes = [HazardAsmParserVariant];
  let AssemblyWriters = [HazardAsmWriter];
  let AllowRegisterRenaming = 1;
}
