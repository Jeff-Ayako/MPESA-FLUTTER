const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp();


exports.paymentCallback = functions.https.onRequest(async (req, res) => {
    const callbackData = req.body.Body.stkCallback;

    console.log('Received payload: ', callbackData);

    const responceCode = callbackData.ResultCode;
    const mCheckoutRequestID = callbackData.CheckoutRequestID;


    if (responceCode === 0) {
        const details = callbackData.callbackData.callbackMetadata.Item;

        var mReceipt;
        var mphonePaidForm;
        var mAmountPaid;


        await details.forEach(entry => {
            switch (entry.Name) {
                case 'MpesaReceiptNumber': mReceipt = entry.Value;
                    break;

                case 'PhoneNumber': mphonePaidForm = entry.Value;
                    break;

                case 'Amount': mAmountPaid = entry.Value;

                    break;

                default:
                    break;

            }
        })

        const mEntryDetails = {
            'receipt': mReceipt,
            'phone': mphonePaidForm,
            'amount': mAmountPaid,
        }
        // find  the document  initialised from the client devie that contains the checkoutrequestId...


        var matchingChoutID = admin.firestore().collectionGroup('deposit').where('CheckoutRequestId', '==', mCheckoutRequestID);
        const QueryResults = await matchingChoutID.get();


        if (!QueryResults.empty) {
            // case matching document is found

            var documentMatchingID = queryResults.docs[0];
            // uodate account balance first get the mail for particular user

            const mail = documentMatchingID.ref.path.split('/')[1];
            documentMatchingID.ref.update(mEntryDetails);

            admin.firestore.CollectionReference('payments').doc(mail).CollectionReference('balance').doc('account').get().then(async (account) => {

                if(account.data() !==undefined){
                    // when it is the first time

                    var balance= account.data().wallet
                    const newBalance= balance+ mAmountPaid


                    console.log('account found updating with balance', newBalance, 'from', balance);

                    return account.ref.update({wallet:newBalance});
                }
                else{
                    console.log('No account found ... creating with new balance', mAmountPaid);

                    try{
                        return admin.firestore.CollectionReference('payments').doc(mail).CollectionReference('balance').doc('account').set({wallet: mAmountPaid,})
                    }
                    catch(err){
                        console.log('error creating account when not found',err);
                        return 1;
                    }
                }


            }).catch((exc)=>{
                console.log('Exception getting the account', exc);
                return {'data':exc}
            })
            console.log('updated document',documentMatchingID.ref.path);



        }
        else{
            console.log('No documnet  found  matching the checkoutrequestID : ', mCheckoutRequestID);

            admin.firestore().doc('lost_found_receipt/deposit_info/all/'+ mCheckoutRequestID ).set(mEntryDetails);

        }
        

    }
    else{
        console.log('Failed transaction');
    }

    res.json({'result':`Payment for ${mCheckoutRequestID} responce received. `})


});
