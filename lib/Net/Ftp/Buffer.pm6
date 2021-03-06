
unit module Net::Ftp::Buffer;

sub split (Buf $buf is rw, Buf $sep, :$empty = False) is export {
    my @lines;
    my ($l, $r, $len) = (0, 0, +$buf - +$sep);
    my $get = 0;
    
    loop (;$r <= $len;$r++) {
        for 0 .. (+$sep - 1) {
            if $buf[$r + $_] == $sep[$_] {
                $get++;
                if ($get == +$sep) || ($l == $r && $empty) {
                    @lines.push: $buf.subbuf($l, $r - $l);
                    $r += +$sep;
                    $l = $r;

                }
            } else{
                $get = 0;last;
            }
        }
    }

    if ($r - $l >= 1) {
        $buf = $buf.subbuf($l, +$buf - $l);
    } 
    
    return @lines;
}

multi sub merge (Buf $lb, Buf $rb) is export {
    my $ret = Buf.new($lb);

    my $len = $lb.elems;

    for 0 .. $rb.elems {
        $ret[$len + $_] = $rb[$_];
    }

    return $ret;
}

multi sub merge (@bufs) is export {
    my Buf $ret .= new();

    my $ln = 0;

    for @bufs -> $buf {
        for 0 .. $buf.elems {
            $ret[$ln + $_] = $buf[$_];
        }
        $ln += $buf.elems;
    }

    return $ret;
}

# vim: ft=perl6

