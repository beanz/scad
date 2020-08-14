
BB623 =   [3, 10, 4, undef, undef, undef, undef, "623"];
BBF623 =   [3, 10, 4, undef, undef, 1, 11.5, "F623ZZ"];
BB624 =   [4, 13, 5, undef, undef, undef, undef, "624"];
BBF624 =   [4, 13, 5, undef, undef, 1, 15, "F624ZZ"];
BB625 =   [5, 16, 5, undef, undef, undef, undef, "625"];
BBF625 =   [5, 16, 5, undef, undef, 1, 18, "F62%ZZ"];
BB608 =   [8, 22, 7, undef, undef, undef, undef, "608"];
BB624VV = [4, 13, 5, 1.5, 3.4, undef, undef, "624VV"];
BB623VV = [3, 12, 4, 1.2, 2.7, undef, undef, "623VV"];

function ball_bearing_id(t) = t[0];
function ball_bearing_od(t) = t[1];
function ball_bearing_h(t) = t[2];
function ball_bearing_is_v(t) = t[3] == undef ? false : true;
function ball_bearing_v_h(t) = t[3];
function ball_bearing_v_d(t) = t[4];
function ball_bearing_is_f(t) = t[5] == undef ? false : true;
function ball_bearing_f_h(t) = t[5];
function ball_bearing_f_d(t) = t[6];
function ball_bearing_name(t) = t[7];

module ball_bearing(t) {
  vitamin(ball_bearing_name(t));
  color(bearing_color) {
    rotate_extrude($fs = 1) {
      if (ball_bearing_is_v(t)) {
        _v_bearing_poly(t);
      } else {if (ball_bearing_is_f(t)) {
          _f_bearing_poly(t);
        } else {
          _bearing_poly(t);
        }
      }
    }
  }
}

module _bearing_poly(t) {
  or = ball_bearing_od(t)/2;
  ir = ball_bearing_id(t)/2;
  h = ball_bearing_h(t);
  race_r = (ir+or)/2;
  race_h = h*0.1;

  polygon(points = [
    [ir, h],
      [race_r-race_h,h], [race_r,h-race_h], [race_r+race_h, h],
           [or, h],
           [or, 0],
      [race_r+race_h,0], [race_r,race_h], [race_r-race_h, 0],
    [ir, 0]]);
}

module _v_bearing_poly(t) {
  or = ball_bearing_od(t)/2;
  v_r = or-ball_bearing_v_d(t)/2;
  ir = ball_bearing_id(t)/2;
  h = ball_bearing_h(t);
  v_h = ball_bearing_v_h(t);
  race_r = (ir+or)/2;
  race_h = h*0.1;

  polygon(points = [
    [ir, h],
      [race_r-race_h,h], [race_r,h-race_h], [race_r+race_h, h],
           [or, h],
           [or, h/2+v_h/2],
         [v_r, h/2],
           [or, h/2-v_h/2],
           [or, 0],
      [race_r+race_h,0], [race_r,race_h], [race_r-race_h, 0],
    [ir, 0]]);
}

module _f_bearing_poly(t) {
  or = ball_bearing_od(t)/2;
  ir = ball_bearing_id(t)/2;
  h = ball_bearing_h(t);
  f_r = ball_bearing_f_d(t)/2;
  f_h = ball_bearing_f_h(t);
  race_r = (ir+or)/2;
  race_h = h*0.1;

  polygon(points = [
    [ir, h],
      [race_r-race_h,h], [race_r,h-race_h], [race_r+race_h, h],
           [or, h],
           [or, f_h],
           [f_r, f_h],
           [f_r, 0],
           [or, 0],
      [race_r+race_h,0], [race_r,race_h], [race_r-race_h, 0],
    [ir, 0]]);
}
