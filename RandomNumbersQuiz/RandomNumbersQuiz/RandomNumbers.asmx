<%@ WebService Language="C#" Class="RandomNumbersQuiz.RandomNumbers" %>
using System;
using System.Web.Services;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Collections.Generic;

namespace RandomNumbersQuiz
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
	class RandomNumbers : System.Web.Services.WebService
	{
    
    public static List<int> randomNumbersList;
    
    public static List<int> getRandomNumbersList(){
        if (randomNumbersList == null){
            List<int> generatedNumbers = new List<int>();
            Random gen = new Random();
            
            for (int i = 0; i < 100000; i++){
                generatedNumbers.Add(gen.Next(int.MaxValue));
            }
            
            randomNumbersList = generatedNumbers;
        }
        
        return randomNumbersList;
    }
    
    private List<int> filteredList(int number){
        List<int> listToReturn = new List<int>();
            foreach (int randomNumber in getRandomNumbersList())
            {
                // filter number
                string randNumString = randomNumber.ToString();
                if (randNumString.Substring(0, number.ToString().Length).Equals(number.ToString()))
                {
                    listToReturn.Add(randomNumber);
                }
                if (listToReturn.Count == 10)
                {
                    break;
                }
            }
        
        return listToReturn;
    }
    
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getNumbersThatStartsWith (int number){
            List<int> listOfNumbers = filteredList(number);
            
            string stringToReturn = new JavaScriptSerializer().Serialize(listOfNumbers);
            return stringToReturn;
        }
        
        struct result{
            public int numID;
            public int numValue;
        }
	}
}
