trigger CustAddDelete on Customers__c (after insert, before delete, after update) {
    if(Trigger.isDelete){
    	if(Trigger.isBefore){
           	List<Customers__c> Name = Trigger.old;
            Triggers_Demo.SendEmail('vvskg1123@gmail.com', 'Customer Deleted', 
                   'Customer! '+Name[0].Name+' is removed from our list and who is in "'+Name[0].Stage__c+ '" stage');
        }
    } else if(Trigger.isInsert){
        if (Trigger.isAfter){
           	List<Customers__c> Name = Trigger.new;
            Triggers_Demo.SendEmail('vvskg1123@gmail.com', 'New Customer is Added', 
                   'Customer! '+Name[0].Name+' is added to our project and the current stage is '+Name[0].Stage__c );
        }
    } else if(Trigger.isUpdate){
        if(Trigger.isAfter){
            List<Customers__c> custClosed = Trigger.new;
            Triggers_Demo.updatePropCustClosed(Trigger.new);
        }
    }
}