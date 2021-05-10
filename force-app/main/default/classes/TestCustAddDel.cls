@isTest
public class TestCustAddDel {
    @isTest static void testCustAddition(){
    	Customers__c custAdd = new Customers__c(Name='Steven Peter',First_Name__c='Steven', 
                                    Last_Name__c='Peter', Stage__c='Open', Customer_Price__c=120000);
        //insert custAdd;
        Test.startTest();
        Database.SaveResult custSave = Database.insert(custAdd,true);
        Test.stopTest();
        System.assert(custSave.isSuccess());
       
        List<String> emailContent = Triggers_Demo.sendEmail('vvskg1123@gmail.com', 'New Customer Added', 
                           'Customer! '+custAdd.Name+' is added to our project and the current stage is '+custAdd.Stage__c+ '" stage');
        
        System.assertEquals('vvskg1123@gmail.com', emailContent[0]);
        System.assertEquals('New Customer Added', emailContent[1]);
        System.assertEquals('Customer! '+custAdd.Name+' is added to our project and the current stage is '+custAdd.Stage__c+ '" stage',
                             emailContent[2]);
    }
    
    @isTest static void testCustDeletion(){
    	Customers__c custAdd = new Customers__c(Name='Steven Peter',First_Name__c='Steven', 
                                    Last_Name__c='Peter', Stage__c='Open', Customer_Price__c=120000);
        insert custAdd;
		
        Test.startTest();
        Database.DeleteResult custResult = Database.delete(custAdd, true);
        Test.stopTest();

		System.assert(custResult.isSuccess()); 
        List<String> emailContent = Triggers_Demo.sendEmail('vvskg1123@gmail.com', 'Customer Deleted', 
                           'Customer! '+custAdd.Name+' is removed from our list and who is in "'+custAdd.Stage__c+ '" stage');
        System.assertEquals('vvskg1123@gmail.com', emailContent[0]);
        System.assertEquals('Customer Deleted', emailContent[1]);
        System.assertEquals('Customer! '+custAdd.Name+' is removed from our list and who is in "'+custAdd.Stage__c+ '" stage',
                             emailContent[2]);
    }
    
    @isTest static void testPropertyUpdate(){
        Customers__c cust = new Customers__c(Name='Steven Peter',First_Name__c='Steven', 
                                   Last_Name__c='Peter', Stage__c='Open', Customer_Price__c=120000);
        insert cust;
        Apartment__c Apt = new Apartment__c(Name = 'Lake View Apartments', 
                                            Total_SqFt_of_the_Building__c=30000, Total_No_Of_Units__c=20);
    	insert Apt;
        Property__c custProp = new Property__c(Apartment_Name__c=Apt.Id, Property_ID__c='DD212', 
                              Name='LakeView Flat',Unit_Type__c='2Bed 2Bath',Status__c='Available');
        insert custProp;
        
        custProp.Property_Sold_To__c = cust.Id;
        System.debug('customer name is '+custProp.Property_Sold_To__c);
        cust.Property_Interested_In__c = custProp.Id;
        System.debug('Property name is '+custProp.Name);
        
        //System.debug(custProp.Property_Sold_To__c  + ' '+cust.Property_Interested_In__c);
 		Test.startTest();
        cust.Stage__c = 'Closed';
        //update cust;
        system.debug(cust.Stage__c);
        Database.SaveResult custUpdate = Database.update(cust);
        System.assert(custUpdate.isSuccess());
    	//update custProp;
        Database.SaveResult custPropUpdate = Database.update(custProp);
        Test.stopTest();
        
        System.assert(custPropUpdate.isSuccess()); 
        System.assertEquals('Sold', custProp.Status__c);
    }
}