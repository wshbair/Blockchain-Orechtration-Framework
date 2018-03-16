// University of Luxembourg/SnT
// Wazen Shbair
// shbair.wazen@uni.lu
// wazen.shbair@gmail.com
// January, 2018

var Web3 = require('web3');
const fs = require('fs');
const solc = require('solc');
var poissonProcess = require('poisson-process');
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8084"));

// Compile the source code
const input = fs.readFileSync('LUXKYC.sol');
const output = solc.compile(input.toString(), 1);
const bytecode = output.contracts[':LUXKYC'].bytecode;
const abi = JSON.parse(output.contracts[':LUXKYC'].interface);
// Contract object
const ioContract = web3.eth.contract(abi);
 
var io = ioContract.new(
  {
    from: web3.eth.accounts[0],
    data: '0x' + bytecode,
    gas: '4700000',
  },
  function (e, contract) {
     if(e){ console.log(e);}
    if (typeof contract.address !== 'undefined') {
      console.log("contract mined: " + contract.address);     
            var contract = ioContract.at(contract.address);
            clientaddresses = new Array();
            delays = new Array();
            var clientnumber=3;

            console.log("Performance Test Start");
	    console.log('start Time:'+new Date().getTime() / 1000 )
	    var starttime=new Date().getTime() / 1000;
            console.log("----------------------------------");        
                var p = poissonProcess.create(40000, function NewClient(){
                delays.push(new Date().getTime() / 1000);     
                var FirstName='test';
                var LastName='test';
                var BirthDate='test';
                var BirthPlace='test';
                var CivilCtatus='test';
                var PassportNumber='123';
                var ExpirationDate='test';
                var IssueDate='test';
                var Country='test';
                var link='test';
                var Facta=true;
                var ResidenceInUS=true;
                var IsPEP=true;  
                var RelativeToPEP=true;   
                var PostalAddress='test';
                var PhoneNumCountry='test';
                var CountryOfResidence='test';
                var LinkToLuxembourg='test';
                var DecisionJustification='test';
                var Frequency='test';
                var addtional='test';
                var funds='test';
                //================================================
                // Blockchain Transactions
                //================================================
                let ClientAddress = web3.personal.newAccount("Wazen"+new Date().getTime()); 
                clientaddresses.push(ClientAddress);
                var counter=web3.eth.accounts.length;
            
                var txhash1= contract.newClient(web3.eth.accounts[counter-1],FirstName,LastName,BirthDate,BirthPlace,CivilCtatus,PassportNumber,ExpirationDate,IssueDate,Country,link, {gas: 2100000, from: web3.eth.accounts[0]});
                var txhash2= contract.SetResidence(web3.eth.accounts[counter-1],Facta,ResidenceInUS,IsPEP,RelativeToPEP,PostalAddress,PhoneNumCountry,{gas: 2100000, from: web3.eth.accounts[0]});
                var txhash3=contract.SetKYC(web3.eth.accounts[counter-1],CountryOfResidence,LinkToLuxembourg,DecisionJustification,{gas: 2100000, from: web3.eth.accounts[0]});
                var txhash4=contract.SetTransaction(web3.eth.accounts[counter-1],Frequency,addtional,funds,{gas: 2100000, from: web3.eth.accounts[0]});

                console.log('KYC Client sent : '+ ClientAddress)
                delays.push(new Date().getTime() / 1000); 
            
                
                if(clientaddresses.length==clientnumber)
                {
                    p.stop();
                    console.log('stoped');
                    var timer=setInterval(function() {
                    var conter=0; 
                    for (var i=0; i<clientaddresses.length;i++)
                    {
                        var resul=CheckRegistationStatus(clientaddresses[i],contract);
                        if(resul)
                        {
                            conter++;
                        }
                    }
                    console.log('Counter value '+conter);
                    if (conter==clientnumber)
                            {
				   
                                var output='';
                                for (i=0;i<=clientaddresses.length;i++)
                                    console.log(delays[i]);
                                    fs.appendFile("Result1.txt",delays[i]+'\n', function(err) {
                                        if(err) {
                                            return console.log(err);
                                        }
                                        console.log("The file was saved!");
					var endtime=new Date().getTime() / 1000;    
					var duration =endtime-starttime    
					console.log('Duration:'+ duration );
					     
                                        }); 
                                    
                                clearInterval(timer);	
                            }
                },3000);    
                }

                });
                p.start();               
		

    }
  }
)
    
//======================================================================================================================
function CheckRegistationStatus(clientaddress, contract) {

		 var clientinfo=contract.GetClientInfoByAddress.call(clientaddress, {gas: 2000000, from: web3.eth.accounts[0]});

		if(web3.toUtf8(clientinfo[1].toString()).length>2)
		 {
             return true;
		 }
         else
         return false;
		
	}

