public class ContactController {
    
    public String searchContactKeyword {get; set;}
    public Integer noOfRecords{get; set;}
    public Integer size{get;set;}
    public String selectedContactId {get; set;}
    
    public static final String NAME = 'Name';
    public static final String EMAIL = 'Email';
    public static final String CONTACT_LEVEL = 'Contact_Level__c';
    public static final String ACCOUNT_ID = 'AccountId';
    public static final String OWNER_ID = 'OwnerId';
    public static final String CREATED_BY_ID = 'CreatedById';
    public static final String CREATED_DATE = 'CreatedDate';
    public String sortingColumn = 'Name'; 
    public String sortingOrder = ' ASC '; 
    public String column = sortingColumn; 
    
    public String query = 'select Id, Name,Email,Contact_Level__c,AccountId,OwnerId,CreatedById,CreatedDate ' +
        'FROM Contact ' +
        'ORDER BY ' + sortingColumn + sortingOrder;
   
    public void sortByName() {
        sortingColumn = NAME;
        sortingOrder();
    }
    public void sortByEmail() {
        sortingColumn = EMAIL;
        sortingOrder();
    }
    public void sortByContactLevel() {
        sortingColumn = CONTACT_LEVEL;
        sortingOrder();
    }
    public void sortByAccountId() {
        sortingColumn = ACCOUNT_ID;
        sortingOrder();
    }
    public void sortByOwnerId() {
        sortingColumn = OWNER_ID;
        sortingOrder();
    }
    public void sortByCreatedById() {
        sortingColumn = CREATED_BY_ID;
        sortingOrder();
    }
    public void sortByCreatedDate() {
        sortingColumn = CREATED_DATE;
        sortingOrder();
    }
    public void sortingOrder() {
        size = 10;
        if (sortingColumn == column) {
            sortingOrder = (sortingOrder == ' ASC ') ? ' DESC ' : ' ASC ';
        } else {
            sortingOrder = ' ASC ';
            column = sortingColumn;
        }
        query = 'SELECT Id, Name, Email, Contact_Level__c, AccountId, OwnerId, CreatedById, CreatedDate ' +
            'FROM Contact ' +
            'ORDER BY ' + sortingColumn + sortingOrder;
        setCon = new ApexPages.StandardSetController(Database.query(query));
        setCon.setPageSize(size);
    }
     
    public List<Contact> Contacts {
        get {
            return (List<Contact>)setCon.getRecords();
        }
        set;
    }
    
    public ApexPages.StandardSetController setCon {
        get {
            if (setCon == null) {
                size = 10;
                String searchContactKeywordCreteria = '%'+(searchContactKeyword == null ? '' : searchContactKeyword)+'%';

                query = 'SELECT Id, Name,Email,Contact_Level__c,AccountId,OwnerId,CreatedById,CreatedDate FROM Contact WHERE Name LIKE :searchContactKeywordCreteria';
                setCon = new ApexPages.StandardSetController(Database.query(query));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }
        set;
    }
    
    public void SearchContacts() {
        setCon = null;
        setCon.setPageNumber(1);
    }
    
    public void DeleteContact() {
        if (selectedContactId == null) {
            return;
        }
        Contact tobeDeleted = null;
        for(Contact a : Contacts){
            if (a.Id == selectedContactId) {
                tobeDeleted = a;
                break;
            }
        }
        if (tobeDeleted != null) {
            List<Case> CaseList = [SELECT Id FROM Case WHERE ContactId =: tobeDeleted.Id];
            if (!CaseList.isEmpty()) {
                delete CaseList;
            }
            if (tobeDeleted != null) {
                delete tobeDeleted;
            }
        }
        setCon = null;
        setCon.getRecords();
    }

}