const calculatePrice = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

    if (!priceInput || !addTaxPrice || !profit) {
    return;
  }

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    if (inputValue.match(/^[0-9]+$/)) {
      const fee = Math.floor(inputValue * 0.1);
      const gain = Math.floor(inputValue - fee);

      addTaxPrice.innerHTML = fee.toLocaleString();
      profit.innerHTML = gain.toLocaleString();
    } else {

      addTaxPrice.innerHTML = '---';
      profit.innerHTML = '---';
    }
  });
};
window.addEventListener("turbo:load", calculatePrice);
window.addEventListener("turbo:render", calculatePrice);