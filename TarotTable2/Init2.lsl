integer DIALOG_CHANNEL = -500;
string START = "Start";
string STOP = "Stop";
string CANCEL = "Cancel";
string SPACE = " ";
string INSTRUCTIONS = "Instructions";
string GUIDE = "Guide";
string ABOUT = "About";
list STOPPED_OPTIONS = [START,SPACE, CANCEL,INSTRUCTIONS,GUIDE,ABOUT];
list STARTED_OPTIONS = [STOP,SPACE, CANCEL,INSTRUCTIONS,GUIDE,ABOUT];

list cards;
integer dialogListener ;
integer dialogInUse = FALSE;
integer DEBUG_MODE = FALSE;

initCards()
{
    cards = [];
    integer i ;
    for(i=0;i<78;++i)
    {
        cards=[i]+cards;
    }
}

string createCommand(integer id,string instruction){
    return "card_"+(string)id+","+instruction;
}

string createMoveCommand(integer id,vector position){
    return "card_"+(string)id+",move,"+(string)position;
}

string createCommandAll(string instruction){
    return "all,"+instruction;
}

startCards()
{
    if(DEBUG_MODE){
        llSetText("please wait...DEBUG MODE",<1,0,0>,1);
        cards = llListSort(cards,1,TRUE);
    }
    else{
        llSetText("please wait",<1,0,0>,1);
        cards = llListRandomize(cards,1);
    }
    integer count = llGetListLength(cards);
    integer i;
    for(i=0;i<count;++i)
    {
        integer cardIndex = llList2Integer(cards,i);
        llMessageLinked(LINK_ALL_CHILDREN,cardIndex,createCommand(i,"card_front"),NULL_KEY);
    }
    llMessageLinked(LINK_ALL_CHILDREN,0,createCommandAll("start"),NULL_KEY);
    llSetText("",<0,0,0>,0);
}

handleGive(string message)
{
    //TODO
}

default
{
    on_rez(integer p)
    {
        llResetScript();
    }
    state_entry()
    {
        //initCards();
        state stopped;
    }
}

state playing
{
    on_rez(integer p)
    {
        llResetScript();
    }
    state_entry()
    {
        startCards();
    }
    touch_start(integer num_detected)
    {
        key user = llDetectedKey(0);
        if(dialogInUse){
            llInstantMessage(user,"This Table is in use, please try again later");
        }
        else{
            dialogListener = llListen(DIALOG_CHANNEL,"",user,"");
            dialogInUse = TRUE;
            llDialog(user, "\nPlease select an option", STARTED_OPTIONS , DIALOG_CHANNEL);
            llSetTimerEvent(60.0);
        }
    }
    listen(integer channel,string name,key id,string message)
    {
        if(channel != DIALOG_CHANNEL){
            return;
        }
        dialogInUse = FALSE;
        if(message == CANCEL){
            llListenRemove(dialogListener);
            llSetTimerEvent(0);
            return;
        }
        if(message == SPACE){
            DEBUG_MODE = !DEBUG_MODE;
            return;
        }
        if(message == STOP){
            state stopped;
            return;
         }
        handleGive(message);
    }
    timer()
    {
        llSetTimerEvent(0);
        llListenRemove(dialogListener);
        dialogInUse = FALSE;
    }
    state_exit()
    {
         llListenRemove(dialogListener);
         dialogInUse = FALSE;
    }
}

state stopped
{
    on_rez(integer p)
    {
        llResetScript();
    }
    state_entry()
    {
        //llMessageLinked(LINK_ALL_CHILDREN,0,createCommandAll("stop"),NULL_KEY);
    }
    touch_start(integer num_detected)
    {
        /*key user = llDetectedKey(0);
        if(dialogInUse){
            llInstantMessage(user,"This Table is in use, please try again later");
            return;
        }
        
        dialogListener = llListen(DIALOG_CHANNEL,"",user,"");
        dialogInUse = TRUE;
        llDialog(user, "\nPlease select an option", STOPPED_OPTIONS , DIALOG_CHANNEL);
        llSetTimerEvent(60.0);*/
        vector pos = llGetPos();
        llMessageLinked(LINK_ALL_CHILDREN,0,createMoveCommand(0,pos+<1,1,0>),NULL_KEY);
        
    }
    /*listen(integer channel,string name,key id,string message)
    {
        if(channel !=  DIALOG_CHANNEL){
            return;
        }
        dialogInUse = FALSE;
        if(message == CANCEL){
            llListenRemove(dialogListener);
            llSetTimerEvent(0);
            return;
        }
        if(message == SPACE){
            DEBUG_MODE = !DEBUG_MODE;
            return;
        }
        if(message == START){
                state playing;
                return;
        }
        handleGive(message);
    }
    timer()
    {
        llSetTimerEvent(0);
        llListenRemove(dialogListener);
        dialogInUse = FALSE;
    }
    state_exit()
    {
         llListenRemove(dialogListener);
         dialogInUse = FALSE;
    }*/
}