def captureu(re; mods):
    match(re; mods)
    | reduce (.captures[] | select(.name != null) | { (.name) : .string } ) as $pair ({}; . + $pair)
    + reduce (.captures[] | select(.name == null) | .string) as $v ({}; .[length + 1 | tostring] = $v)
    + {"0": .string};

def captureu($val): ($val|type) as $vt | if $vt == "string" then captureu($val; null)
   elif $vt == "array" and ($val | length) > 1 then capture($val[0]; $val[1])
   elif $vt == "array" and ($val | length) > 0 then capture($val[0]; null)
   else error( $vt + " not a string or array") end;

def subu($re; s; flags):
  def subg: [explode[] | select(. != 103)] | implode;
  # "fla" should be flags with all occurrences of g removed; gs should be non-nil if flags has a g
  def sub1(fla; gs):
    def mysub:
      . as $in
      | [match($re; fla)]
      | if length == 0 then $in
        else .[0] as $edit
        | ($edit | .offset + .length) as $len
        # create the "capture" object:
        | $edit
        | reduce (.captures[] | select(.name != null) | { (.name) : .string } ) as $pair ({}; . + $pair)
          + reduce (.captures[] | select(.name == null) | .string) as $v ({}; .[length + 1 | tostring] = $v)
          + {"0": .string}
        | $in[0:$edit.offset]
          + s
          + ($in[$len:] | if length > 0 and gs then mysub else . end)
        end ;
    mysub ;
  (flags | index("g")) as $gs
  | (flags | if $gs then subg else . end) as $fla
  | sub1($fla; $gs);
#
def subu($re; s): subu($re; s; "");
# repeated substitution of re (which may contain named captures)
def gsubu($re; s; flags): subu($re; s; flags + "g");
def gsubu($re; s): subu($re; s; "g");

def lstrip: sub("^\\s+"; "");
def rstrip: sub("\\s+$"; "");
def strip: lstrip | rstrip;

def isstr: type == "string";
def isobj: type == "object";
def isarr: type == "array";
def upper: ascii_upcase;
def lower: ascii_downcase;

def median: if isarr then
    if length == 0 then
        null
    else sort | if length % 2 == 0 then (.[length / 2] + .[length / 2 - 1]) / 2 else .[(length / 2) | floor] end
    end
else . end;

def common_len($a; $b): [range([$a, $b] | map(length) | min + 1)] | map(select($a[:.] == $b[:.])) | max;
def lines: split("\n") | .[:-1];
def unlines: join("\n");
def words: split(" ") | map(select(length != 0));
def unwords: join(" ");
def fuzzy_match($f): test($f | split("") | [""] + . + [""] | join(".*"));
def count: group_by(.) | map([.[0], length]);
def count_val: group_by(.) | map(length);
def count_str: group_by(.) | map({key: .[0], value: length}) | sort_by(.value) | from_entries;
def count_tostr: group_by(.) | map({key: (.[0] | tostring), value: length}) | sort_by(.value) | from_entries;
def enumerate: [[range(length)], .] | transpose;
def find(f):
    reduce .[] as $val (null;
        if . == null and ($val | f) then $val
        else . end);
def find_index(f):
    enumerate
    | reduce .[] as [$ind, $val] (null;
        if . == null and ($val | f) then $ind
        else . end);
def chunk($n): . as $in | [range(0; length; $n)] | map($in[.:.+$n]);
def window($n): . as $in | [range(0; ([(length - $n + 1), 1] | max))] | map($in[.:.+$n]);

def fromhex:
    def moveto($l; $g; $o): if . >= $l and . <= $g then . - $l + $o else . end;
    sub("^0[xX]"; "") | explode | map(moveto(48; 57; 0) | moveto(97; 102; 10) | moveto(65; 70; 10))
    | reverse | enumerate | map(pow(16; .[0]) * .[1]) | add;
def split_space: split(" ") | map(select(length > 0));

def color(n; s): "\u001b[\(n)m\(s)\u001b[0m";
def red(s): color(31; s);
def green(s): color(32; s);
def yellow(s): color(33; s);
def blue(s): color(34; s);
def purple(s): color(35; s);
def cyan(s): color(36; s);
def red_bg(s): color(41; s);
def green_bg(s): color(42; s);
def yellow_bg(s): color(43; s);
def blue_bg(s): color(44; s);
def purple_bg(s): color(45; s);
def cyan_bg(s): color(46; s);
