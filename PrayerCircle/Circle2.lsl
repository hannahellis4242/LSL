integer black = -1;
string blackName = "Black";
integer blackFlame = -1;
string blackFlameName = "BlackFlame";

integer red = -1;
string redName = "Red";
integer redFlame = -1;
string redFlameName = "RedFlame";

integer white = -1;
string whiteName = "White";
integer whiteFlame = -1;
string whiteFlameName = "WhiteFlame";

list flameParticleRules = [
            PSYS_SRC_PATTERN,PSYS_SRC_PATTERN_EXPLODE,
            PSYS_SRC_BURST_RADIUS,0,
            PSYS_SRC_ANGLE_BEGIN,0,
            PSYS_SRC_ANGLE_END,0,
            PSYS_PART_START_COLOR,<1.000000,0.734375,0.468750>,
            PSYS_PART_END_COLOR,<1.000000,1.000000,1.000000>,
            PSYS_PART_START_ALPHA,1,
            PSYS_PART_END_ALPHA,1,
            PSYS_PART_START_GLOW,0.001,
            PSYS_PART_END_GLOW,0.03,
            PSYS_PART_BLEND_FUNC_SOURCE,PSYS_PART_BF_SOURCE_ALPHA,
            PSYS_PART_BLEND_FUNC_DEST,PSYS_PART_BF_ONE_MINUS_SOURCE_ALPHA,
            PSYS_PART_START_SCALE,<0.031250,0.100000,0.000000>,
            PSYS_PART_END_SCALE,<0.500000,0.500000,0.000000>,
            PSYS_SRC_TEXTURE,"",
            PSYS_SRC_MAX_AGE,0,
            PSYS_PART_MAX_AGE,3,
            PSYS_SRC_BURST_RATE,1.5,
            PSYS_SRC_BURST_PART_COUNT,7,
            PSYS_SRC_ACCEL,<0.000000,0.000000,0.000000>,
            PSYS_SRC_OMEGA,<0.000000,0.000000,0.000000>,
            PSYS_SRC_BURST_SPEED_MIN,0.5,
            PSYS_SRC_BURST_SPEED_MAX,0.5,
            PSYS_PART_FLAGS, PSYS_PART_TARGET_LINEAR_MASK
        ];

integer setCandle(integer candle,integer flame,integer value){
    float alpha = 0.0;
    if( value ){
        alpha = 1.0;
    }
    llSetLinkAlpha(candle,alpha,ALL_SIDES);
    llSetLinkAlpha(flame,0,ALL_SIDES);
    list rules = [];
    if(value){
        rules = flameParticleRules;
    }
    llLinkParticleSystem(flame,rules);
    return 0;
}

integer identify(string name,integer number){
    if(name==blackName){
        black=number;
        return TRUE;
    }
    if(name==blackFlameName){
        blackFlame=number;
        return TRUE;
    }
    if(name==redName){
        red=number;
        return TRUE;
    }
    if(name==redFlameName){
        redFlame=number;
        return TRUE;
    }
    if(name==whiteName){
        white=number;
        return TRUE;
    }
    if(name==whiteFlameName){
        whiteFlame=number;
        return TRUE;
    }
    return FALSE;
}

default
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        //setup
        {
            integer numPrims = llGetNumberOfPrims();
            integer linkNum = 1;
            for (; linkNum <= numPrims; ++linkNum) {
                identify(llGetLinkName(linkNum),linkNum);
            }
        }
        
        //debug code
        integer numPrims = llGetNumberOfPrims();
        integer linkNum = 1;
        for (; linkNum <= numPrims; ++linkNum) {
            string childName = llGetLinkName(linkNum);
            llSay(0,"Link Number " + (string)linkNum + ": " + childName);
        }
        llSay(0,"black : "+(string)black);
        llSay(0,"red : "+(string)red);
        llSay(0,"white : "+(string)white);
        llSay(0,"blackFlame : "+(string)blackFlame);
        llSay(0,"redFlame : "+(string)redFlame);
        llSay(0,"whiteFlame : "+(string)whiteFlame);
        state Start;
    }
}

state Start
{
    state_entry()
    {
        llSay(0,"Start");
        setCandle(black,blackFlame,FALSE);
        setCandle(red,redFlame,FALSE);
        setCandle(white,whiteFlame,FALSE);
    }
    touch_start(integer n){
        state Begin;
    }
}

state Begin
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"Begin");
        setCandle(black,blackFlame,FALSE);
        setCandle(red,redFlame,FALSE);
        setCandle(white,whiteFlame,FALSE);
    }
    touch_start(integer n){
        state BlackOut;
    }
}

state BlackOut
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"BlackOut");
        setCandle(black,blackFlame,TRUE);
        setCandle(red,redFlame,FALSE);
        setCandle(white,whiteFlame,FALSE);
    }
    touch_start(integer n){
        state RedOut;
    }
}

state RedOut
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"RedOut");
        setCandle(black,blackFlame,TRUE);
        setCandle(red,redFlame,TRUE);
        setCandle(white,whiteFlame,FALSE);
    }
    touch_start(integer n){
        state WhiteOut;
    }
}

state WhiteOut
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"WhiteOut");
        setCandle(black,blackFlame,TRUE);
        setCandle(red,redFlame,TRUE);
        setCandle(white,whiteFlame,TRUE);
    }
    touch_start(integer n){
        state Ritual;
    }
}

state Ritual
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"Ritual");
        setCandle(black,blackFlame,TRUE);
        setCandle(red,redFlame,TRUE);
        setCandle(white,whiteFlame,TRUE);
    }
    touch_start(integer n){
        state WhiteIn;
    }
}

state WhiteIn
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"WhiteIn");
        setCandle(black,blackFlame,TRUE);
        setCandle(red,redFlame,TRUE);
        setCandle(white,whiteFlame,FALSE);
    }
    touch_start(integer n){
        state RedIn;
    }
}

state RedIn
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"RedIn");
        setCandle(black,blackFlame,TRUE);
        setCandle(red,redFlame,FALSE);
        setCandle(white,whiteFlame,FALSE);
    }
    touch_start(integer n){
        state BlackIn;
    }
}

state BlackIn
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"BlackIn");
        setCandle(black,blackFlame,FALSE);
        setCandle(red,redFlame,FALSE);
        setCandle(white,whiteFlame,FALSE);
    }
    touch_start(integer n){
        state End;
    }
}

state End
{
    on_rez(integer start){
        state default;
    }
    state_entry()
    {
        llSay(0,"End");
        setCandle(black,blackFlame,FALSE);
        setCandle(red,redFlame,FALSE);
        setCandle(white,whiteFlame,FALSE);
    }
    touch_start(integer n){
        state Start;
    }
}