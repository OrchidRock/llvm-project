
class HazardReg<bits<16> Enc, string n> : Register<n> {
  let HWEncoding = Enc;
  let Namespace = "Hazard";
}

// CPU Registers
class HazardGPRReg<bits<16> Enc, string n> : HazardReg<Enc, n>;

// FPU Registers
class HazardFPReg<bits<16> Enc, string n> : HazardReg<Enc, n>;

// CP0 Registers
class HazardC0Reg<bits<16> Enc, string n> : HazardReg<Enc, n>;

let Namespace = "Hazard" in {
    def ZERO : HazardGPRReg<0, "zero">, DwarfRegNum<[0]>;
    
    // Reserved for assembler
    def AT   : HazardGPRReg<1, "1">,    DwarfRegNum<[1]>;

    // Values for results and expression evaluation
    def V0   : HazardGPRReg<2, "2">,    DwarfRegNum<[2]>;
    def V1   : HazardGPRReg<3, "3">,    DwarfRegNum<[3]>;

    // Arguments
    def A0   : HazardGPRReg<4, "4">,    DwarfRegNum<[4]>;
    def A1   : HazardGPRReg<5, "5">,    DwarfRegNum<[5]>;
    def A2   : HazardGPRReg<6, "6">,    DwarfRegNum<[6]>;
    def A3   : HazardGPRReg<7, "7">,    DwarfRegNum<[7]>;
    
    // Temporary
    def T0   : HazardGPRReg<8, "8">,    DwarfRegNum<[8]>;
    def T1   : HazardGPRReg<9, "9">,    DwarfRegNum<[9]>;
    def T2   : HazardGPRReg<10, "10">,  DwarfRegNum<[10]>;
    def T3   : HazardGPRReg<11, "11">,  DwarfRegNum<[11]>;
    def T4   : HazardGPRReg<12, "12">,  DwarfRegNum<[12]>;
    def T5   : HazardGPRReg<13, "13">,  DwarfRegNum<[13]>;
    def T6   : HazardGPRReg<14, "14">,  DwarfRegNum<[14]>;
    def T7   : HazardGPRReg<15, "15">,  DwarfRegNum<[15]>;

    // Saved
    def S0   : HazardGPRReg<16, "16">,  DwarfRegNum<[16]>;
    def S1   : HazardGPRReg<17, "17">,  DwarfRegNum<[17]>;
    def S2   : HazardGPRReg<18, "18">,  DwarfRegNum<[18]>;
    def S3   : HazardGPRReg<19, "19">,  DwarfRegNum<[19]>;
    def S4   : HazardGPRReg<20, "20">,  DwarfRegNum<[20]>;
    def S5   : HazardGPRReg<21, "21">,  DwarfRegNum<[21]>;
    def S6   : HazardGPRReg<22, "22">,  DwarfRegNum<[22]>;
    def S7   : HazardGPRReg<23, "23">,  DwarfRegNum<[23]>;

    // Temporary
    def T8   : HazardGPRReg<24, "24">,  DwarfRegNum<[24]>;
    def T9   : HazardGPRReg<25, "25">,  DwarfRegNum<[25]>;
    
    // Reserved for OS.
    def K0   : HazardGPRReg<26, "26">,  DwarfRegNum<[26]>;
    def K1   : HazardGPRReg<27, "27">,  DwarfRegNum<[27]>;

    // The Pointer of Global Static Data.
    def GP   : HazardGPRReg<28, "gp">,  DwarfRegNum<[28]>;

    // Stack Pointer
    def SP   : HazardGPRReg<29, "sp">,  DwarfRegNum<[29]>;

    // Frame Pointer
    def FP   : HazardGPRReg<30, "fp">,  DwarfRegNum<[30]>;
    
    // Return Address
    def RA   : HazardGPRReg<31, "ra">,  DwarfRegNum<[31]>;

    // FPU Registers
    foreach I = 0-31 in
        def F#I : HazardFPReg<I, "f"#I>, DwarfRegNum<[!add(I, 32)]>;

    // HI/LO
    def HI : HazardReg<0, "ac0">, DwarfRegNum<[64]>;
    def LO : HazardReg<0, "ac0">, DwarfRegNum<[65]>;

    def PC : Register<"pc">;
    
    // CP0 Registers
    def COUNT   : HazardC0Reg<9, "9">;
    def COMPARE : HazardC0Reg<11, "11">;
    def STATUS  : HazardC0Reg<12, "12">;
    def CAUSE   : HazardC0Reg<13, "13">;
    def EPC     : HazardC0Reg<14, "14">;
    def CONFIG  : HazardC0Reg<16, "16">;
}   

def CPURegs : RegisterClass<"Hazard", [i32], 32, (add
  ZERO, AT,
  V0, V1, A0, A1, A2, A3,
  T0, T1, T2, T3, T4, T5, T6, T7,
  S0, S1, S2, S3, S4, S5, S6, S7,
  T8, T9,
  K0, K1, GP, SP, FP, RA)>;

def CPURAReg : RegisterClass<"Hazard", [i32], 32, (add RA)>, Unallocatable;
def CPUSPReg : RegisterClass<"Hazard", [i32], 32, (add SP)>, Unallocatable;

// Registers Class.

def HILO    : RegisterClass<"Hazard", [i32], 32, (add HI, LO)>;
def CP0Regs : RegisterClass<"Hazard", [i32], 32, (add
  COUNT, COMPARE, STATUS, CAUSE, EPC, CONFIG)>, Unallocatable;


// Register Operands.
def CPURegsOpnd : RegisterOperand<CPURegs>;
def CP0RegsOpnd : RegisterOperand<CP0Regs>;
