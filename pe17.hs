euler17 = length . filter (flip notElem " ,-") . foldl1 (++) $ [numberWords x | x <- [1..1000]]
numberWords n
    | (n < 20)      = units !! n
    | (n < 100)     = let (d, m) = n `divMod` 10   in tens !! d ++
                          (if m > 0 then "-" ++ numberWords m else "")
    | (n < 1000)    = let (d, m) = n `divMod` 100  in units !! d ++ " hundred" ++
                          (if m > 0   then " and " ++ numberWords m else "")
    | (n < 1000000) = let (d, m) = n `divMod` 1000 in numberWords d ++ " thousand," ++
                          (if m > 0 then " " else "") ++
                          (if m `elem` [1..99] then "and " else "") ++ numberWords m
    where units = ["","one","two","three","four","five","six","seven","eight","nine","ten",
                       "eleven","twelve","thirteen","fourteen","fifteen",
                           "sixteen","seventeen","eighteen","nineteen"]
          tens  = ["","","twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety"]