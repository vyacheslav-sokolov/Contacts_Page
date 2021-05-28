@IsTest
public with sharing class ContactControllerTest {

    @IsTest
    public static void DeleteContactTest() {
        Test.startTest();
        Contact cont = new Contact(LastName = 'TestCont', Contact_Level__c = 'Primary');
        insert cont;
        Test.stopTest();
        ContactController contactController = new ContactController();
        contactController.Contacts = new List<Contact>{cont};
        contactController.selectedContactId = cont.Id;
        contactController.DeleteContact();
        List<Contact> conts = [SELECT Id FROM Contact];
        System.assertEquals(0, conts.size(), 'Количество всех контактов после удаление должно быть равно 0.');
    }

    @IsTest
    public static void sortByNameTest() {
        ContactController ctController = new ContactController();
        ctController.sortByName();
        System.assertEquals(ContactController.NAME, ctController.sortingColumn);
    }

    @IsTest
    public static void sortByEmailTest() {
        ContactController ctController = new ContactController();
        ctController.sortByEmail();
        System.assertEquals(ContactController.EMAIL, ctController.sortingColumn);
    }
    
     @IsTest
    public static void sortByContactLevelTest() {
        ContactController ctController = new ContactController();
        ctController.sortByContactLevel();
        System.assertEquals(ContactController.CONTACT_LEVEL, ctController.sortingColumn);
    }
    
     @IsTest
    public static void sortByAccountIdTest() {
        ContactController ctController = new ContactController();
        ctController.sortByAccountId();
        System.assertEquals(ContactController.ACCOUNT_ID, ctController.sortingColumn);
    }
    
     @IsTest
    public static void sortByOwnerIdTest() {
        ContactController ctController = new ContactController();
        ctController.sortByOwnerId();
        System.assertEquals(ContactController.OWNER_ID, ctController.sortingColumn);
    }
    
     @IsTest
    public static void sortByCreatedByIdTest() {
        ContactController ctController = new ContactController();
        ctController.sortByCreatedById();
        System.assertEquals(ContactController.CREATED_BY_ID, ctController.sortingColumn);
    }
    
     @IsTest
    public static void sortByCreatedDateTest() {
        ContactController ctController = new ContactController();
        ctController.sortByCreatedDate();
        System.assertEquals(ContactController.CREATED_DATE, ctController.sortingColumn);
    }

    @IsTest
    public static void SearchContactsTest() {
        ContactController ctController = new ContactController();
        ctController.SearchContacts();
        System.assertEquals(1, ctController.setCon.getPageNumber());
    }
}