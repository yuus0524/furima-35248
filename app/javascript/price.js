function price () {
 const itemPrice = document.getElementById("item-price")
 itemPrice.addEventListener("keyup", () => {
  const fee = Math.floor(itemPrice.value * 0.1);
  const saleProfit = itemPrice.value - fee;
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  addTaxPrice.innerHTML = `${fee}`;
  profit.innerHTML = `${saleProfit}`;
 });
}

window.addEventListener("load", price);