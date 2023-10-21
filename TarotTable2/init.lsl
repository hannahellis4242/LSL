string CHILD_OBJECT = "tarot_card_linked";

float SPACING_X = 0.2;
float SPACING_Y = 0.1;
float HOVER = -0.005;
vector INIT_OFFSET=<0.5,0.6,HOVER>;


layoutCards()
{
    llSetText("loading",<1,0,0>,1);
    rotation initRot = llGetRot();
    vector initPos = llGetPos();
    integer i;
    integer j;
    for(i=0;i<6;++i)
    {
        for(j=0;j<13;++j)
        {
            vector grid_pos = <i*SPACING_X,j*SPACING_Y,0>;
            vector pos = initPos - INIT_OFFSET + grid_pos;
            llRezObject(CHILD_OBJECT,pos,<0,0,0>,initRot,0);
        }
    }
    llSetText("0",<0,0,0>,0);
}

default
{
    state_entry()
    {
    }
    touch_start(integer n){
        layoutCards();
    }
}
