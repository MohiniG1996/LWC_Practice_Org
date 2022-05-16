trigger RestCallOut on Contact (after insert) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        RestAPICallOut1.asynchronousCallOut();

    }

}