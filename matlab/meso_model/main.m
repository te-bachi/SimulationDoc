
meso1.x = 5;
meso1.y = 10;
meso1.func = @hello;

meso2.x = 5;
meso2.y = 10;
meso2.func = @hello;

[x y zzz] = meso1.func(6, 9, 500);
fprintf(1, '%d %d %d\n', x, y, zzz);

[x y zzz] = meso2.func(10, 5, 600);
fprintf(1, '%d %d %d\n', x, y, zzz);
