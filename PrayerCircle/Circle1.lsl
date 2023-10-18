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
        llSetLinkAlpha(black,0,ALL_SIDES);
        llSetLinkAlpha(blackFlame,0,ALL_SIDES);
        llSetLinkAlpha(red,0,ALL_SIDES);
        llSetLinkAlpha(redFlame,0,ALL_SIDES);
        llSetLinkAlpha(white,0,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,0,ALL_SIDES);
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
        llSetLinkAlpha(black,0,ALL_SIDES);
        llSetLinkAlpha(blackFlame,0,ALL_SIDES);
        llSetLinkAlpha(red,0,ALL_SIDES);
        llSetLinkAlpha(redFlame,0,ALL_SIDES);
        llSetLinkAlpha(white,0,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,0,ALL_SIDES);
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
        llSetLinkAlpha(black,1,ALL_SIDES);
        llSetLinkAlpha(blackFlame,1,ALL_SIDES);
        llSetLinkAlpha(red,0,ALL_SIDES);
        llSetLinkAlpha(redFlame,0,ALL_SIDES);
        llSetLinkAlpha(white,0,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,0,ALL_SIDES);
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
        llSetLinkAlpha(black,1,ALL_SIDES);
        llSetLinkAlpha(blackFlame,1,ALL_SIDES);
        llSetLinkAlpha(red,1,ALL_SIDES);
        llSetLinkAlpha(redFlame,1,ALL_SIDES);
        llSetLinkAlpha(white,0,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,0,ALL_SIDES);
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
        llSetLinkAlpha(black,1,ALL_SIDES);
        llSetLinkAlpha(blackFlame,1,ALL_SIDES);
        llSetLinkAlpha(red,1,ALL_SIDES);
        llSetLinkAlpha(redFlame,1,ALL_SIDES);
        llSetLinkAlpha(white,1,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,1,ALL_SIDES);
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
        llSetLinkAlpha(black,1,ALL_SIDES);
        llSetLinkAlpha(blackFlame,1,ALL_SIDES);
        llSetLinkAlpha(red,1,ALL_SIDES);
        llSetLinkAlpha(redFlame,1,ALL_SIDES);
        llSetLinkAlpha(white,1,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,1,ALL_SIDES);
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
        llSetLinkAlpha(black,1,ALL_SIDES);
        llSetLinkAlpha(blackFlame,1,ALL_SIDES);
        llSetLinkAlpha(red,1,ALL_SIDES);
        llSetLinkAlpha(redFlame,1,ALL_SIDES);
        llSetLinkAlpha(white,0,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,0,ALL_SIDES);
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
        llSetLinkAlpha(black,1,ALL_SIDES);
        llSetLinkAlpha(blackFlame,1,ALL_SIDES);
        llSetLinkAlpha(red,0,ALL_SIDES);
        llSetLinkAlpha(redFlame,0,ALL_SIDES);
        llSetLinkAlpha(white,0,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,0,ALL_SIDES);
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
        llSetLinkAlpha(black,0,ALL_SIDES);
        llSetLinkAlpha(blackFlame,0,ALL_SIDES);
        llSetLinkAlpha(red,0,ALL_SIDES);
        llSetLinkAlpha(redFlame,0,ALL_SIDES);
        llSetLinkAlpha(white,0,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,0,ALL_SIDES);
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
        llSetLinkAlpha(black,0,ALL_SIDES);
        llSetLinkAlpha(blackFlame,0,ALL_SIDES);
        llSetLinkAlpha(red,0,ALL_SIDES);
        llSetLinkAlpha(redFlame,0,ALL_SIDES);
        llSetLinkAlpha(white,0,ALL_SIDES);
        llSetLinkAlpha(whiteFlame,0,ALL_SIDES);
    }
    touch_start(integer n){
        state Start;
    }
}