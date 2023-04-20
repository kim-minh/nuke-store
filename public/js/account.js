$(document).ready(function() {

    const loginWindow = '<form class="loginWindow" action="/login" method="post" style="display:none"> \
    <div class="loginForm"> \
      <label for="username"><b>Username</b></label> \
      <input type="text" placeholder="Enter Username" name="username" required> \
      <label for="password"><b>Password</b></label> \
      <input type="password" placeholder="Enter Password" name="password" required> \
      <button type="submit">Login</button> \
    </div> \
    <div class="action" style="background-color:#f1f1f1"> \
      <button type="button" class="cancelbtn">Cancel</button> \
      <span class="signUp"><a href="javascript:void(0)">Sign up</a></span> \
    </div> \
  </form>';

  const logOutWindow = '<div class="logOutWindow" style="display: none">\
  <div class="logOutPlace">\
    <h3>You\'re already logged in</h3>\
    <div class="action">\
      <button type="button" class="cancelbtn">Cancel</button>\
      <button type="button" class="update">Update</button>\
      <button class="logOut"><a href="javascript:void(0)">Log out</a></button>\
    </div>\
  </div>\
</div>';

    const signUpWindow = '<form class="signUpWindow" action="/register" method="post" style="display:none"> \
    <div class="signUpForm"> \
      <label class="username" for="username"><b>Username</b></label> \
      <input class="username" type="text" placeholder="Enter Username" name="username" required>\
      <label for="email"><b>Email</b></label>\
      <input type="email" placeholder="Enter your email" name="email" required>\
      <label for="password"><b>Password</b></label>\
      <input type="password" placeholder="Enter Password" name="password" required>\
      <label for="name"><b>Name</b></label>\
      <input type="text" placeholder="Enter your name" name="name" required>\
      <label for="phone"><b>Phone number</b></label>\
      <input type="number" placeholder="Enter your phone number" name="phone" required>\
      <label for="address"><b>Address</b></label>\
      <input type="text" placeholder="Enter your address" name="address" required>\
      <label for="credit"><b>Credit Number</b></label>\
      <input type="number" placeholder="Enter your credit number" name="credit" required>\
    </div>\
    <div class="action" style="background-color:#f1f1f1">\
      <button type="button" class="cancelbtn">Cancel</button>\
      <button type="submit" class="signupbtn">Sign Up</button>\
    </div>\
  </form>';

    $(document.body).append(loginWindow, logOutWindow, signUpWindow);
    
    if (sessionStorage.getItem('account')) $("#account").text(sessionStorage.getItem('accountName'));
    $('.loginWindow .loginForm button').click(function() {
        if (!sessionStorage.getItem('account')) {
          console.log("data");
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