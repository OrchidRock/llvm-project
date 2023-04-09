

class Format<bits<4> val> {
  bits<4> Value = val;
}

def Pseudo      : Format<0>;
def FrmR        : Format<1>;
def FrmI        : Format<2>;
def FrmJ        : Format<3>;
def FrmOther    : Format<4>;

class HazardInst<dag outs, dag ins, string asmstr, 
                 list<dag> pattern, InstrItinClass itin, 
                 Format f> : Instruction {
  field bits<32> Inst;
  Format Form =  f;
  
  let Namespace = "Hazard";

  let Size = 4;

  bits<6> Opcode = 0;
  let Inst{31-26} = Opcode;
  
  let AsmString = asmstr;
  let Pattern   = pattern;
  let Itinerary = itin;
  
}

class HazardPseudo<dag outs, dag ins, string asmstr, list<dag> pattern>
        : HazardInst<outs, ins, asmstr, pattern, IIPseudo, Pseudo> {
  let isCodeGenOnly = 1;
  let isPseudo = 1;  
}
