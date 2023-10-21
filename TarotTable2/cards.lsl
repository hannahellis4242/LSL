string ID = "card_<id>"; //note id is the number of the card
string ALL = "all";
integer card_front = 0;
integer card_back = 78;
integer faceUp = FALSE;
integer started = FALSE;

setCard(){
    if(started){
        llSetAlpha(1,ALL_SIDES);
    }
    else{
        llSetAlpha(0,ALL_SIDES);
    }

    if(faceUp){
        llSetTexture((string)card_front,0);
    }
    else{
        llSetTexture((string)card_back,0);
    }
}

handleStart(){
    faceUp = FALSE;
    started = TRUE;
    setCard();
}

handleStop(){
    faceUp = FALSE;
    started = FALSE;
    setCard();
}

handleCardChange(integer front, integer back){
    card_front = front;
    card_back = back;
    setCard();
}

handleMove(list params){
    //llSetStatus(STATUS_PHYSICS, TRUE);
    vector position = llList2Vector(params,0);
    llSetPos(position);
    //llMoveToTarget(position,0.5);
    //llSetStatus(STATUS_PHYSICS, FALSE);
}

default
{
    state_entry(){
        started=TRUE;
        setCard();
    }
    
    changed(integer change){
        // reset script when the owner or the inventory changed
        if (change & (CHANGED_OWNER | CHANGED_INVENTORY))
            llResetScript();
    }

    link_message(integer sender_num, integer num, string msg, key id){
        if(sender_num != LINK_ROOT){
            return;
        }
        
        list commandList = llParseString2List(msg,[","],[" "]);
        string target = llList2String(commandList,0);
        if(target!=ID && target !=ALL){
            return;
        }
        
        string command = llList2String(commandList,1);
        list params = llList2ListSlice(commandList,2,-1,1,0);
        llSay(0,llDumpList2String(params,","));
        if(command == "move"){
            handleMove(params);
            return;
        }
        if(command == "start"){
            handleStart();
            return;
        }
        if(command == "stop"){
            handleStop();
            return;
        }
        if(command == "card_front"){
            handleCardChange(num,card_back);
            return;
        }
        if(command == "card_back"){
            handleCardChange(card_front,num);
            return;
        }
        if(command == "reset"){
            llResetScript();
            return;
        }
    }
    touch_start(integer n){
        if(started && !faceUp)
        {
            faceUp = TRUE;
            setCard();
        }
    }
}
