/*

Copyright (c) 2017 SnT and University of Luxembourg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

contract owned {
    function owned() { owner = msg.sender; }
    address internal owner;
    // If the owner calls this function, the function is executed
    // and otherwise, an exception is thrown.
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract LUXKYC is owned {
struct client {
        /* Client Information */
        uint index;
        bytes32  FirstName;
        bytes32  LastName;
        bytes32  BirthDate;
        bytes32  BirthPlace;
        bytes32  CivilCtatus;
        uint PassportNumber;
        bytes32  ExpirationDate;
        bytes32  IssueDate;
        bytes32  Country;
        string link;

        //Authorization 
        address[] AuthorizesAccess;
        address[] UnAuthorizedAccess;
    }
struct Transaction{
    bytes32  TransactionFrequency;
    bytes32  AdditionalInfo;
    bytes32  FundResource; 
}
struct KYC{
    bytes32  CountryOfResidence;
    bytes32  LinkToLuxembourg;
    bytes32  DecisionJustification;
}
struct Residence{
        bool Facta;
        bool ResidenceInUS;
        bool IsPEP;
        bool RelativeToPEP;
        bytes32  PostalAddress;
        bytes32  PhoneNumCountry;
}
    address public owner;
    mapping(address => client) clients;
    mapping(address => Residence) Residences;
    mapping(address => KYC) KYCs;
    mapping(address => Transaction) Transactions;

    address[] private clientIndex;

// function to check if the client is registed before
function isClient(address clientAddress) public constant returns(bool isIndeed) {
    if(clientIndex.length == 0) return false;
    return (clientIndex[clients[clientAddress].index] == clientAddress);
  }

event LOGNewClient(address _ClientAddress, bytes32  _FirstName, bytes32  _LastName, uint index);

// Register New Client    
function newClient(address _ClientAddress, bytes32 _FirstName, bytes32  _LastName, bytes32  _BirthDate, bytes32  _BirthPlace, bytes32  _CivilCtatus, uint _PassportNumber, bytes32  _ExpirationDate,
                    bytes32  _IssueDate, bytes32 _Country, string link) onlyOwner {
    client c = clients[_ClientAddress];
    c.FirstName=_FirstName;
    c.LastName=_LastName;
    c.BirthDate=_BirthDate;
    c.BirthPlace=_BirthPlace;
    c.CivilCtatus=_CivilCtatus;
    c.PassportNumber=_PassportNumber;
    c.ExpirationDate=_ExpirationDate;
    c.IssueDate=_IssueDate;
    c.Country=_Country;
    c.link=link;
    c.index=clientIndex.push(_ClientAddress)-1;
    LOGNewClient(_ClientAddress,_FirstName, _LastName,clientIndex.length-1);
    }

    /* Residence  Information */
function SetResidence(address _ClientAddress, bool _Facta, bool _ResidenceInUS, bool _IsPEP, bool _RelativeToPEP, bytes32  _PostalAddress, 
                    bytes32  _PhoneNumCountry) onlyOwner{
    Residences[_ClientAddress].Facta=_Facta;
    Residences[_ClientAddress].ResidenceInUS=_ResidenceInUS;
    Residences[_ClientAddress].IsPEP=_IsPEP;
    Residences[_ClientAddress].RelativeToPEP=_RelativeToPEP;
    Residences[_ClientAddress].PostalAddress=_PostalAddress;
    Residences[_ClientAddress].PhoneNumCountry=_PhoneNumCountry;
     }
 
    /* KYC  Information */
function SetKYC(address _ClientAddress, bytes32 _CountryOfResidence, bytes32  _LinkToLuxembourg, 
                    bytes32  _DecisionJustification) onlyOwner {
        KYCs[_ClientAddress].CountryOfResidence=_CountryOfResidence;
        KYCs[_ClientAddress].LinkToLuxembourg=_LinkToLuxembourg;
        KYCs[_ClientAddress].DecisionJustification=_DecisionJustification;
        }

    /* Transaction */
function SetTransaction(address _ClientAddress, bytes32  _TransactionFrequency, bytes32  _AdditionalInfo, bytes32 _FundResource) 
         onlyOwner {
     Transactions[_ClientAddress].TransactionFrequency=_TransactionFrequency;
     Transactions[_ClientAddress].AdditionalInfo=_AdditionalInfo;
     Transactions[_ClientAddress].FundResource=_FundResource; 
    }


/* Get Client Identification info using address */
function GetClientInfoByAddress (address clientAddress) constant onlyOwner returns (bytes32 _FirstName, bytes32 _LastName, bytes32 _BirthDate, 
                                                                          bytes32  _BirthPlace, bytes32  _CivilCtatus, uint _PassportNumber, 
                                                                          bytes32  _ExpirationDate, bytes32  _IssueDate, bytes32  _Country, string link){

if (isClient(clientAddress)){
    _FirstName=clients[clientAddress].FirstName;
    _LastName=clients[clientAddress].LastName;
    _BirthDate= clients[clientAddress].BirthDate;
    _BirthPlace= clients[clientAddress].BirthPlace;
    _CivilCtatus= clients[clientAddress].CivilCtatus;
    _PassportNumber=clients[clientAddress].PassportNumber;
    _ExpirationDate= clients[clientAddress].ExpirationDate;
    _IssueDate=clients[clientAddress].IssueDate;
    _Country=clients[clientAddress].Country;
    link=clients[clientAddress].link;
}

    }


function GetResidanceinfo (address clientAddress) constant returns (bool Facta, bool ResidenceInUS, 
                                        bool IsPEP, bool RelativeToPEP, bytes32  PostalAddress, bytes32  PhoneNumCountry){
    Facta=Residences[clientAddress].Facta;
    ResidenceInUS=Residences[clientAddress].ResidenceInUS;
    IsPEP= Residences[clientAddress].IsPEP;
    RelativeToPEP= Residences[clientAddress].RelativeToPEP;
    PostalAddress= Residences[clientAddress].PostalAddress;
    PhoneNumCountry=Residences[clientAddress].PhoneNumCountry;
  
} 

function GetKYC (address clientAddress) constant returns (bytes32  CountryOfResidence, bytes32  LinkToLuxembourg, 
                                                                        bytes32  DecisionJustification){
        CountryOfResidence=KYCs[clientAddress].CountryOfResidence;
        LinkToLuxembourg=KYCs[clientAddress].LinkToLuxembourg;
        DecisionJustification= KYCs[clientAddress].DecisionJustification;
     }

function GetTransaction (address clientAddress) constant returns (bytes32  TransactionFrequency, bytes32  AdditionalInfo, bytes32  FundResource){
    TransactionFrequency=Transactions[clientAddress].TransactionFrequency;
    AdditionalInfo=Transactions[clientAddress].AdditionalInfo;
    FundResource= Transactions[clientAddress].FundResource;
    }







//Give Authorization
function GiveAuthorization(address clientaddress, address bankaddress) {
    if(isClient(clientaddress)){
            clients[clientaddress].AuthorizesAccess.push(bankaddress);
    }
}  
// wirthdraw Authorization
function TailAuthorization(address clientaddress, address bankaddress){
    if(isClient(clientaddress)){
            clients[clientaddress].UnAuthorizedAccess.push(bankaddress);
     }

}  
// Check Authorization
function IsAuthorized(address clientaddress, address bankaddress) constant returns(bool result) {
    if(isClient(clientaddress)){
        client c=clients[clientaddress];
        address temp;
        uint i;
        bool Authorized=false;
        bool NotAuthorized=false;
        for (i= 0; i < c.AuthorizesAccess.length; i++) {
            temp=c.AuthorizesAccess[i];
            if (temp==bankaddress)
            Authorized=true;
            }
        for (i = 0; i < c.UnAuthorizedAccess.length; i++) {
            temp=c.UnAuthorizedAccess[i];
            if (temp==bankaddress)
            NotAuthorized=true;
            }    
        if(Authorized && !NotAuthorized)
        result=true;
        else
        result=false;
}
}

// Get Information based on Authrization 
function GetClientInfoPart1 (address clientAddress, address bankaddress) constant returns (bytes32 _FirstName, bytes32 _LastName, bytes32 _BirthDate, 
                                                                          bytes32 _BirthPlace, bytes32 _CivilCtatus, uint _PassportNumber, 
                                                                          bytes32 _ExpirationDate, bytes32 _IssueDate, bytes32 _Country, string link){

if (isClient(clientAddress) && IsAuthorized(clientAddress,bankaddress) ){
    _FirstName=clients[clientAddress].FirstName;
    _LastName=clients[clientAddress].LastName;
    _BirthDate= clients[clientAddress].BirthDate;
    _BirthPlace= clients[clientAddress].BirthPlace;
    _CivilCtatus= clients[clientAddress].CivilCtatus;
    _PassportNumber=clients[clientAddress].PassportNumber;
    _ExpirationDate= clients[clientAddress].ExpirationDate;
    _IssueDate=clients[clientAddress].IssueDate;
    _Country=clients[clientAddress].Country;
    link=clients[clientAddress].link;
    }
}

function GetClientInfoPart2 (address clientAddress, address bankaddress) constant returns (bool Facta, bool ResidenceInUS, 
                                        bool IsPEP, bool RelativeToPEP, bytes32  PostalAddress, bytes32  PhoneNumCountry){

if (isClient(clientAddress) && IsAuthorized(clientAddress,bankaddress) ){
    Facta=Residences[clientAddress].Facta;
    ResidenceInUS=Residences[clientAddress].ResidenceInUS;
    IsPEP= Residences[clientAddress].IsPEP;
    RelativeToPEP= Residences[clientAddress].RelativeToPEP;
    PostalAddress= Residences[clientAddress].PostalAddress;
    PhoneNumCountry=Residences[clientAddress].PhoneNumCountry;
    }
}    

function GetClientInfoPart3 (address clientAddress, address bankaddress) constant returns (bytes32  CountryOfResidence, bytes32  LinkToLuxembourg, 
                                                                        bytes32  DecisionJustification){
    if (isClient(clientAddress) && IsAuthorized(clientAddress,bankaddress) ){
        CountryOfResidence=KYCs[clientAddress].CountryOfResidence;
        LinkToLuxembourg=KYCs[clientAddress].LinkToLuxembourg;
        DecisionJustification= KYCs[clientAddress].DecisionJustification;
        }
    }

function GetClientInfoPart4 (address clientAddress, address bankaddress) constant returns (bytes32  TransactionFrequency, bytes32  AdditionalInfo, bytes32  FundResource){
if (isClient(clientAddress) && IsAuthorized(clientAddress,bankaddress) ){
    TransactionFrequency=Transactions[clientAddress].TransactionFrequency;
    AdditionalInfo=Transactions[clientAddress].AdditionalInfo;
    FundResource= Transactions[clientAddress].FundResource;
    }
}

function destroy() {
    if (msg.sender == owner) { 
        suicide(owner);
    }
}

// Converts 'string' to 'bytes32'
function stringToBytes(string s) returns (bytes32) {
    bytes memory b = bytes(s);
    uint r = 0;
    for (uint i = 0; i < 32; i++) {
        if (i < b.length) {
            r = r | uint(b[i]);
        }
        if (i < 31) r = r * 256;
    }
    return bytes32(r);
}
}
