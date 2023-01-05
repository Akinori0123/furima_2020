const pay = ()=> {
  var payjp = Payjp('pk_test_f25d5194aea7043cd8f2011b')
  var elements = payjp.elements();

  var numberElement = elements.create('cardNumber');
  var expiryElement = elements.create('cardExpiry');
  var cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then(function (response) {
      if (response.status === 402) {
      } else {
        console.log(response)
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name='pay_form[token]'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // document.getElementById("card_number").removeAttribute("name");
      // document.getElementById("card_expiry").removeAttribute("name");
      // document.getElementById("card_cvc").removeAttribute("name");
      document.getElementById("charge-form").submit();
    });
  })
}

window.addEventListener("load", pay);