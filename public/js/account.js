$(document).ready(function() {
    
    if (sessionStorage.getItem('account')) $("#account").text(sessionStorage.getItem('accountName'));
    $('.loginWindow .loginForm button').click(function() {
        if (!sessionStorage.getItem('account')) {
            (async() => {
                const res = await fetch('/accounts', {
                    method: 'GET'
                });
                if (res.ok) {
                    const data = await res.json();
                    $("#account").text(data.username);
                    sessionStorage.setItem('accountName', data.username);
                    sessionStorage.setItem('account', data.id);
                }
            }) ();
        } else $("#account").text(sessionStorage.getItem('accountName'));
    });

    $("#account").click(function() {
        if (sessionStorage.getItem('account')) {
            $(".logOutWindow").show();
        } else $(".loginWindow").show();
    });
    $(".loginWindow .action button.cancelbtn").click(function() {
        $(".loginWindow").hide();
        $(".loginWindow .loginForm input").val('');
    });
    $(".loginWindow .action .signUp").click(function() {
        $(".signUpWindow").show();
    });
    $(".logOutWindow .logOutPlace .action button.cancelbtn").click(function() {
        $(".logOutWindow").hide();
    });
    //log out button do sumthin
    $(".logOutWindow .logOutPlace .action button.logOut").click(async function() {
        sessionStorage.removeItem('accountName');
        sessionStorage.removeItem('account');
        $("#account").text('My Account');
        await fetch("/logout", {
            method: 'GET'
        });
        location.reload();
    });
    $(".logOutWindow .logOutPlace .action button.update").click(function() {
        $(".signUpWindow").show();
        $(".signUpWindow").attr('action', '/update');
        $(".username").remove();
        $(".signUpForm input").removeAttr('required');
        $(".signupbtn").text('Update');
    });
    $(".signUpWindow .action button.cancelbtn").click(function() {
        $(".signUpWindow").hide();
        $(".signUpWindow .signUpForm input").val('');
    });

});