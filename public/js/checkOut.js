$(document).ready(function() {
    const shoesData = sessionStorage.getItem('shoesData');
    const arr = JSON.parse(shoesData);
    (async() => {
      const data = await getShoes(shoesData);
      $(data).each(function(index) {
        //cho quantity trang trc vao day
        const quantity = arr[index].quantity;
        const quantityInStock = this.quantityInStock;
        const quantityDiv ='<div class="quantity"> <div class="minus"></div> <div class="value">' + quantity + '</div> <div class="plus"></div> <p class="warning" style="display:none">In Stock: <span>'+ quantityInStock +'</span></p></div>';
        $('.checkOutArea .products table tbody').append('<tr> <td><span>'+ 
        this.name + '</span></td> <td>'+quantityDiv+'</td> <td>' +
        'Brand: ' + this.brand + '</br>Shoes type: ' + this.type + '</br>Color: ' + this.color + '</br>Size: ' + this.size + ' US</td> <td>$<span class="price">' + 
        this.price + '</span></td> <td class="remove"> <p>X</p> </td> </tr>');
        this.quantity = quantity;
      });
      updatePrice();
      checkStock();
      return data;
    })()
    .then((data) => {
      $('.remove p').click(function() {
        data.splice($('.remove p').index(this), 1);
        $(this).closest('tr').remove();
        updatePrice();
      })

      $('.minus').click(function() {
        let num = Number($(this).siblings('div.value').eq(0).text());
        if(num !== 1) {
          let price = Number($(this).parents('tr').eq(0).find('span.price').text());
          price -= price/num;
          $(this).parents('tr').eq(0).find('span.price').text(''+price+'');
          num -= 1;
          data[$('.minus').index(this)].quantity = num;
          $(this).siblings('div.value').eq(0).text(''+ num +'');
          updatePrice();
          checkStock();
        }
      });

    $('.plus').click(function() {
      let num = Number($(this).siblings('div.value').eq(0).text());
      const index = $('.plus').index(this);
      if (quantity < data[index].quantityInStock) {
        let price = Number($(this).parents('tr').eq(0).find('span.price').text());
        price += price/num;
        $(this).parents('tr').eq(0).find('span.price').text(''+price+'');
        num += 1;
        data[index].quantity = num;
        $(this).siblings('div.value').eq(0).text(''+ num +'');
        updatePrice();
        checkStock();
      }
    });
    //nut confirm phai log in
    $('#confirm').click(function() {
      if (!checkStock()) {
        alert("Out of stock!");
      } else if(!sessionStorage.getItem('account')) {
        alert("Please log in to continue");
      } else {
        const order = {
          shoes: data,
          amount: $('#amount').text(),
          requiredDate: $('#requiredDate').val()
        };
        placeOrder(order);
      }
    });
  });
    getInfo();
});
//kiểm tra giá
function updatePrice() {
  let total = 0;
  $('.checkOutArea .products tbody tr td').children('span.price').each(function() {
    const price = Number($(this).text());
    total += price;
  });
  $('.checkOutArea .confirmDetail .total span').text(''+total+'');
}
//kiểm tra quan từng row một
function checkStock() {
  let gud = true;
  $('.checkOutArea .products tbody tr td').find('div.quantity').each(function() {
    const quantity = Number($(this).find('div.value').first().text());
    const quantityInStock = Number($(this).find('p.warning span').first().text());
    if(quantity > quantityInStock) {
      $(this).find('p.warning').first().show();
      gud = false;
    } else {
      $(this).find('p.warning').first().hide();
    };
  });
  return gud;
}

async function getShoes(shoesData) {
  const res = await fetch('/shoes', {
    method: "POST",
    headers: {
      'Content-Type': 'application/json',
    },
    body: shoesData
  });
  const data = await res.json();
  return data;
}

async function getInfo() {
  const res = await fetch('/accountInfo', {
    method: 'GET'
  });
  if (!res.ok) {
    return;
  } else {
    const data = await res.json();
    $('#name').text('Name: ' + data.name);
    $('#phone').text('Phone Number: ' + data.phoneNumber);
    $('#address').text('Address: ' + data.address);
  }
}

async function placeOrder(orders) {
  await fetch('/order', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(orders)
  });
}