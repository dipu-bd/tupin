# Elements of the grammar

### Program 

    STATEMENTS;
    FUNCTION_DEFINITION { }
    CONTROL_STRUCTURE { }
    { MULTI_STATEMENTS } 

### Statements 

    EXPRESSION;
    [ PRINT STATEMENT ];

### Expression 
    
    VARI = ABLE, DE = CLARATION   
    BOOLEAN == EX > PRESSION
    ARITH + MATIC / EXPRESSION 
    ( BRACKETS ) 
    FUNCTION ( CALL )
    { ARRAY DECLARATION }

### Function Definition

    def FUNC_NAME ( ARG_LIST ) { FUNC_BODY }
    ARG_LIST = ID1, ID2, ..., IDn, OID1=val, [ OID2=val, ... OIDn=val ]

### Function Call    

    FUNC_NAME ( PARAM_LIST ) 
    PARAM_LIST = ARRAY_DECL 

### Print Statement 

    [ list of STRINGs or EXPRESSIONs ];

### ARRAY Declaration 
    
    // single dimensional
    { VAL1, VAL2, .. VALn }
    // multi dimensional
    { {VAL1, VAL2}, VAL3, { VAL4, VAL5, { VAL6, VAL7 }, VAL8 } }

### Variable Declaration 

    // single declaration
    VARIABLE_NAME = INITIAL_VALUE
    // multiple declaration
    VAR_A = INIT_A, VAR_B = INIT_B, ... VAR_X = INIT_X


