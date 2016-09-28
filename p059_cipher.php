<?php

$line = file_get_contents('p059_cipher.txt');
$input_bytes = explode(',', trim($line));
$input_length = count($input_bytes);



$best_counts = [ 0, 0, 0 ];
$best_chars = [ '', '', '' ];
for($decrypt_char = 'a'; strlen($decrypt_char) < 2; $decrypt_char++) {
    $decrypt_byte = ord($decrypt_char);
    $printable_counts = [ 0, 0, 0 ];
    $string = "";
    for($i = 0; $i < count($input_bytes); $i++) {
        $input_byte = (int) $input_bytes[$i];
        $xor_byte = $input_byte ^ $decrypt_byte;
        $char = chr($xor_byte);
        $string .= $char;
        $printable_counts[$i % 3] += ctype_alpha($char);
    }
    for($j = 0; $j < 3; $j++) {
        if($printable_counts[$j] > $best_counts[$j]) {
            $best_counts[$j] = $printable_counts[$j];
            $best_chars[$j] = $decrypt_char;
        }
    }
}

print_r($best_chars);
print_r($best_counts);

// Try Decrypting now
$string = "";
$sum = 0;
for($i = 0; $i < count($input_bytes); $i++) {
    $input_byte = (int) $input_bytes[$i];
    $decrypt_byte = ord($best_chars[$i % 3]);
    $xor_byte = $input_byte ^ $decrypt_byte;
    $sum += $xor_byte;
    $char = chr($xor_byte);
    $string .= $char;
}

echo $string . PHP_EOL;
echo $sum . PHP_EOL;




