const int           MY_CONST    = 64;

typedef struct {
    int             TestField1[MY_CONST];
} TestStruct1;

typedef struct {
    int             TestField1;
    int             TestField2[MY_CONST];
    TestStruct1     TestField3;
} TestStruct2;
