window.addEventListener('load', function(){

const addTaxPrice = document.getElementById("add-tax-price")
const profit = document.getElementById("profit")
const priceInput = document.getElementById("item-price")
  priceInput.addEventListener('input', function(){
    const inputValue = this.value;
    if (inputValue < 300) {
      addTaxPrice.innerHTML = 0
    } else if (inputValue > 9999999) {
      addTaxPrice.innerHTML = 0
    } else {
      addTaxPrice.innerHTML = Math.floor(inputValue * 0.1).toLocaleString();
    }
    if (inputValue < 300) {
      profit.innerHTML = 0
    } else if (inputValue > 9999999) {
      profit.innerHTML = 0
    } else {
      profit.innerHTML = Math.ceil(inputValue * 0.9).toLocaleString();
    }
  })
})