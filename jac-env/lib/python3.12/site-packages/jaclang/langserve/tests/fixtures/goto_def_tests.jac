node SomeNode {
    has some_attr: int;
}

walker SomeWalker {
    can with `root entry {
        visit [-->(`?SomeNode:some_attr==10)];
    }
}
