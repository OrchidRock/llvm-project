
def CC_Hazard : CallingConv<[
  // Promote i8/i16 arguments to i32.
  CCIfType<[i1, i8, i16], CCPromoteToType<i32>>,

  CCIfType<[i32, f32], CCAssignToStack<4, 4>>,
]>;

def RetCC_Hazard : CallingConv<[
  CCIfType<[i1, i8, i16], CCPromoteToType<i32>>,
  
  CCIfOrigArgWasNotVectorFloat<CCIfType<[i32]>,
                               CCAssignToReg<[V0,V1,A0,A1]>>
]>;

def CSR_Hazard : CalleeSavedRegs<(add RA, FP, (sequence "S%u", 7, 0))>;
def CSR_Interrupt_32: CalleeSavedRegs<(add (sequence "A%u", 3, 0),
                                           (sequence "S%u", 7, 0),
                                           (sequence "V%u", 1, 0),
                                           (sequence "T%u", 9, 0),
                                           RA, FP, GP, AT, LO, HI)>;
