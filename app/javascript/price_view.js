window.addEventListener('load', () => {
  const tax = 10
  const price_elem = document.getElementById('item-price');
  price_elem.addEventListener('input', () => {
    const price = Number(price_elem.value)
    if (300 <= price && price <= 9999999) {
      const tax_price = Math.floor(price * tax / 100)
      const profit = price - tax_price
      document.getElementById('add-tax-price').innerHTML = tax_price
      document.getElementById('profit').innerHTML = profit
    } else {
      document.getElementById('add-tax-price').innerHTML = ""
      document.getElementById('profit').innerHTML = ""
    };
  });
});
