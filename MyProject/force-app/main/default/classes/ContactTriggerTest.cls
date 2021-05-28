@IsTest
public with sharing class ContactTriggerTest {

    @IsTest
    public static void CreateCaseForContactTest() {
        Test.startTest();
        Contact cont = new Contact(LastName = 'TestCont');
        insert cont;
        Test.stopTest();
        List<Case> cases = [SELECT Id, Priority, ContactId FROM Case WHERE ContactId = :cont.Id LIMIT 1];
        System.assertEquals(1, cases.size(), 'Для каждого нового контакта должен создаваться кейс.');
    }

    @IsTest
    public static void CreateCaseForPrimaryContactTest() {
        Test.startTest();
        Contact cont = new Contact(LastName = 'TestCont', Contact_Level__c = 'Primary');
        insert cont;
        Test.stopTest();
        List<Case> cases = [SELECT Id, Priority, ContactId FROM Case WHERE ContactId = :cont.Id LIMIT 1];
        if (!cases.isEmpty()) {
            System.assertEquals('High', cases[0].Priority);
        }
    }

    @IsTest
    public static void CreateCaseForSecondaryContactTest() {
        Test.startTest();
        Contact cont = new Contact(LastName = 'TestCont', Contact_Level__c = 'Secondary');
        insert cont;
        Test.stopTest();
        List<Case> cases = [SELECT Id, Priority, ContactId FROM Case WHERE ContactId = :cont.Id LIMIT 1];
        if (!cases.isEmpty()) {
            System.assertEquals('Medium', cases[0].Priority);
        }
    }

    @IsTest
    public static void CreateCaseForTertiaryContactTest() {
        Test.startTest();
        Contact cont = new Contact(LastName = 'TestCont', Contact_Level__c = 'Tertiary');
        insert cont;
        Test.stopTest();
        List<Case> cases = [SELECT Id, Priority, ContactId FROM Case WHERE ContactId = :cont.Id LIMIT 1];
        if (!cases.isEmpty()) {
            System.assertEquals('Low', cases[0].Priority);
        }
    }

    @IsTest
    public static void CreateCaseWithAccountForContactTest() {
        Test.startTest();
        Account acc = new Account(Name = 'AccName');
        insert acc;
        Contact cont = new Contact(LastName = 'TestCont', AccountId = acc.Id);
        insert cont;
        Test.stopTest();
        List<Case> cases = [SELECT Id, Priority, ContactId, AccountId FROM Case WHERE ContactId = :cont.Id LIMIT 1];
        if (!cases.isEmpty()) {
            System.assertEquals(acc.Id, cases[0].AccountId);
        }
    }
}