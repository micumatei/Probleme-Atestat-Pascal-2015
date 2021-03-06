(* Scrieţi un program C/C++ care citeşte de la tastatură un text ce conține mai *)
(* multe cuvinte separate între ele prin unul sau mai multe spații și afișează *)
(* primul cuvânt ce conține un număr maxim de vocale. (Textul are cel mult 250 *)
(*     caractere, litere mici  și spații.) *)
program atestat_2015_50;
type vector=array[1..100] of string;
var v :vector;
    s :string;
    n, i, max_vocale, sfarsit :integer;
    ok :boolean;

{ Obs. Metoda de rezolvare
     - citim textul in variabila 's'
     - eliminam spatiile duble, adica daca intre doua cuvinte se afla doua sau
       mai multe spatii elimina spatiile in plus si ne asiguram ca se afla doar
       un spatiu intre ele
    - salvam cuvintele separat intr-un vector
    - parcurgem vectorul si folosim o functie sa vedem fiecare cuvant cate
      vocale are fiecare cuvant si in variabila 'max_vocale' o sa salvam
      indicele din vector a cuvantului cu cele mai multe vocale
    - afisam cuvantul din vector cu indiceme max_vocale 
}


function este_vocala(c :char):boolean;
{ Parametri:
    - 'c' -> un caracter
  Return:
    - 'True' -> daca 'c' este vocala
    - 'False' -> daca 'c' nu este vocala
}
begin
case c of
    { daca 'c' are una din valorile de mai jos, este vocala }
    'a' : este_vocala := true;
    'e' : este_vocala := true;
    'i' : este_vocala := true;
    'o' : este_vocala := true;
    'u' : este_vocala := true;
    else { daca nu, nu este vocala }
        este_vocala := false;
    end;
end;



function nr_vocale(s :string):integer;
{ Parametri:
    - 's' -> sirul cu care o sa lucram
  Return:
    - integer -> numarul de vocale din sirul 's'
}
var i :integer;
begin
nr_vocale := 0;

{ parcurgem sirul }
for i := 1 to length(s) do { parcurgem caractelele sirului }
    if este_vocala(s[i]) then { daca caracterul e vocala }
        nr_vocale := nr_vocale + 1; { il numaram }
end;


{ Program Principal }
begin
write('Textul :');
readln(s);

{ eliminam orce spatiu alb de la inceputul lui 's' }
while s[1] = ' ' do
    delete(s, 1, 1);

{ eliminam spatiile in plus din 's' }
while pos('  ', s) <> 0  do { cat timp gasimt doua spatii libere unu langa altu
                            in sirul 's' }
    delete(s, pos('  ', s), 1); { deletam unu din ele }


{ adugam un spatiu alb la finalul lui 's' }
s := s + ' ';

{ punem fiecare cuvant in vectorul 'v' }
n := 0;
while pos(' ', s) <> 0 do
    begin
    sfarsit := pos(' ', s); { gasim sfarsitul unui cuvant }

    n := n + 1; { numaram cuvantu }

    v[n] := copy(s, 1, sfarsit-1); { adaugam cuvantul in vector }
    { folosim 'sfarsit-1' deoarece nu vrem sa fie copiat si spatil }
    
    delete(s, 1, sfarsit); { scoatem cuvantul din string }
    { folosim 'sfarsit' fara acel '-1' deoarece vrem sa fie sters si spatiul }
    end;


{ aflam care e numarul maxim de vocale pe care il are un cuvant din textul dat}
max_vocale := 0;

for i := 1 to n do
    if nr_vocale(v[i]) > max_vocale then
        max_vocale := nr_vocale(v[i]);


{ afisam primul cuvant care are numarul de vocale egal cu numarul maxim de vocale }
ok := false;  { nu am afisat nici un cuvant }
i := 0 ;

while not ok do { cat timp nu am afisat nici un cuvant }
    begin
    i := i + 1; { trecem la urmatorul cuvant }
    if nr_vocale(v[i])  = max_vocale then { daca cuvantul are numarul de vocale
                                        egal cu maximul }
        begin
        writeln(v[i]);
        ok := true; { am afisat un cuvant }
        end;
    end;


readln;
end.

{ Obs.
    *pos = primeste 2 parametri
            1) un sir de caractere pe care vrom sa il cautam
            2) alt sir de caractere in care vrem sa cautam
          returneaza pozitia de inceput a primului sir(1) in sirul al doilea
          (2) sau 0 daca sirul 1 nu a fost gasit in sirul 2 
    *delete = primeste 3 parametri
            1) sirul de unde vrem sa deletam
            2) din ce pozitie in sir dorim sa deletam
            3) cate caractere vrem sa deletam
            procedura deleteaza din sirul primit ca prim paramteru de pe
            pozitia primita ca al doilea parametru numaru de caractere
            specificate in al treilea parametru
    *copy = primeste 3 parametri
            1) stringul din care copieam
            2) din ce pozitie din sir dorim sa copiam
            3) cate caractere dorim sa copiam
            functia retuneaza o copie a caracterelor din stringul primit ca
            prim parametru, va copia de pe pozitia primica ca al doilea
            parametru numarul de caractere specificate in al treilea parametru
}

