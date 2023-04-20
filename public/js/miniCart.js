let total = 0;
$(document).ready(function() {
    $(".right .cart .cart-ico").click(function(){
        $(".miniCart").show();
    });
    isEmpty();
    $(".cart button.cartCloser").click(function() {
        $(".miniCart").hide();
    });
    //create new li for minicart and change the price being show
    $(".buyingWindow .details .confirmButton button:nth-child("+ 1 +")").click(function() {
        const shoeName = $(".buyingWindow .details .description").find("span").eq(0).text();
        const price = $(".buyingWindow .details .description p.price").find("span").eq(0).text();
        total += +price;

        const id = $(".buyingWindow div.data span.id").text();
        const quantity = $(".buyingWindow .details .description div.quantity div.value").text();
        const color = $(".buyingWindow .details .description ul.colorChoose li.choosen").text();
        const size = $(".buyingWindow .details .description ul.sizeChoose li.choosen").text().substr(0, 2);
        const singlePrice = +$(".buyingWindow .details .description .price span").text();
        console.log(singlePrice);

        let duplicate = false;
        $(".miniCart .cart ul li").each(function() {
            if (id === $(this).find("div.data span.id").text() &&
                color === $(this).find('div.data span.color').text() &&
                size === $(this).find('div.data span.size').text()) {
                $(this).find("div.quantity p").text(function(index, preQuantity) {
                    return +preQuantity + +quantity;
                });
                const currentQuantity = $(this).find("div.quantity p").text();
                $(this).find("p.price span").text(+currentQuantity * singlePrice);

                duplicate = true;
                return false;
            }
        });

        if (!duplicate) {
            const quantityDiv = '<div class="quantity"><p>' + quantity + '</p></div>';
            const data = '<div class="data" style="display:none"><span class="id">' + id +
            '</span><span class="color">'+ color +
            '</span><span class="size">'+ size + '</span></div>';

            $(".miniCart .cart ul").append('<li><p>'+ shoeName +'</p> '+quantityDiv+' <div class="itemRemover"><p>X</p></div> <p class="price"><span>'+ (singlePrice * quantity)+'</span> USD</p> '+data+' </li>');
        }
        isEmpty();
        updatePrice();
        $(".buyingWindow").hide();
    });
    //remove item from cart
    $(".miniCart .cart ul").on("click", "li div.itemRemover", function() {
        $(this).closest('li').remove();
        const price = Number($(this).siblings("p.price").find("span").text());
        total -=price;
        isEmpty();
        updatePrice();
    });
    //save data using session storage
    $("a.checkOut").click(function(e) {
        if(!isEmpty()) {
            transferId();
        } else {
            e.preventDefault();
            alert('Cart is empty!');
        }
    });
    $(".cart .cartFooter").click(function() {
        if(!isEmpty()) {
            transferId();
        } else {
            e.preventDefault();
            alert('Cart is empty!');
        }
    });

});

function isEmpty() {
    if(!$(".miniCart .cart ul li").length) {
        $(".cart .cartFooter").html('<p class="empty">Empty</P>');
        $(".miniCart .cart ul").hide();
        return true;
    }
    else {
        $(".cart .cartFooter").html('<p>Total: <span>'+total+'</span> USD</p> <a class="checkOut" href="checkOut.html">Check Out</a>');
        $(".miniCart .cart ul").show();
        return false;
    };
}

function updatePrice() {
    $(".right .cart strong.price").text(''+total+' USD');
}
//luu id vao tung bien tang dan trong session storage
function transferId() {
    const shoesData = [];
    $(".miniCart .cart ul").children('li').each(function() {
        const id = $(this).find('span.id').text();
        const color = $(this).find('span.color').text();
        const size = $(this).find('span.size').text();
        //them quantity
        const quantity = +$(this).find('div.quantity p').text();
        const data = { 
            "id": id,
            "color": color,
            "size": size,
            "quantity": quantity
        };
        shoesData.push(data);
    });
    sessionStorage.setItem("shoesData", JSON.stringify(shoesData));
}