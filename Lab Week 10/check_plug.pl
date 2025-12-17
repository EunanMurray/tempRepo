:- op(1150, xfx, <- ).
:- op(950,xfy, &).

working(toaster) <-
   plug(p1) &
   connected(p1,s1) &
   live(p1).

working(microwave) <-
   plug(p2) &
   connected(p2,s2) &
   live(p2).

plug(P) <-
   wired_correctly(P) &
   fuse_ok(P).

live(X) <-
   connected(X,Y) &
   live(Y).

live(outside) <- true.

askable(connected(p1,s1)).
askable(connected(p2,s2)).
connected(s1,outside) <- true.
connected(s2,outside) <- true.

wired_correctly(p1) <-
   terminal(p1,live) &
   terminal(p1,neutral) &
   terminal(p1,earth).

wired_correctly(p2) <-
   terminal(p2,live) &
   terminal(p2,neutral) &
   terminal(p2,earth).

terminal(p1,live) <- true.
terminal(p1,neutral) <- true.
terminal(p1,earth) <- true.

terminal(p2,live) <- true.
terminal(p2,neutral) <- true.
terminal(p2,earth) <- true.

fuse_ok(p1) <- true.
fuse_ok(p2) <- true.