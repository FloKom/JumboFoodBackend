const fetch = (...args)=>
    import('node-fetch').then(({default:fetch})=>fetch(...args))

const paymentGateway = 'https://pay.ikwen.com/'
let details = {
   'username': 'jumboservice',
   'password': 'LkCYH0XimAq0',
};
let formBody = [];
for (let property in details) {
 let encodedKey = encodeURIComponent(property);
 let encodedValue = encodeURIComponent(details[property]);
 formBody.push(encodedKey + "=" + encodedValue);
}

formBody = formBody.join("&");


module.exports.getToken = ()=>{
    return fetch(paymentGateway + 'v2/token',{
       method:'POST',
       headers:{
          'Content-Type' :'application/x-www-form-urlencoded'
       },
       body:formBody
       
    }).then((res)=>res.json())
 }
 
//  module.exports.innitPayment = (token, phone, amount, operator, uui4)=>{
//     let headers = new Headers()
//     headers.append('Authorization', 'Bearer '+ token)
//     headers.append("X-Payment-Provider", operator)
//     headers.append('Accept-Language', 'en')
//     headers.append('Content-Type', 'application/json')
//     headers.append('X-Target-Environment','sandbox')
//     headers.append('X-Reference-Id', uui4)
//     headers.append('X-Notification-Url','http://api-cm.eskalearning.com/payment_callback')
//     return fetch(paymentGateway + 'v2/payment/init',{
//        method:'POST',
//        headers,
//        body:JSON.stringify(
//           {
//              phone,
//              amount,
//              payer_id:'client@provider.com'
//           }
//        )
//    }).then((res)=>res.json())
//  } 

 
 module.exports.getPaymentStatus = (token, pay_token)=>{
   //  let headers = new Headers()
   //  headers.append('Authorization', 'Bearer '+ token)
   //  headers.append('Accept-Language', 'en')
    return fetch(paymentGateway + "v2/payment/"+pay_token,{
       method:'GET',
       headers:{
         Authorization: 'Bearer '+ token,
         'Accept-Language': 'en'
       }
    }).then((res)=>res.json())
 }