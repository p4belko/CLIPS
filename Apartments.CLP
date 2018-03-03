(deftemplate byt
	(slot mesto(type SYMBOL))
	(slot cena(type INTEGER))
	(slot poschodie(type INTEGER))
	(multislot miestnosti (type SYMBOL))
	(multislot rozmeryKuchyne(type INTEGER))
	(multislot rozmerySpalna_1(type INTEGER))
	(multislot rozmerySpalna_2(type INTEGER))
	(multislot rozmerySatnik(type INTEGER))
	(multislot rozmeryObyvacky (type INTEGER))
	(slot pocet (type INTEGER))
)


(deffacts byty
	(byt
		(mesto Bratislava)
		(cena 105000)
		(poschodie 4)
		(miestnosti kuchyna obyvacka detska_izba spalna_1 spalna_2 satnik)
		(rozmeryKuchyne 3 3)
		(rozmeryObyvacky 5 5)
		(rozmerySpalna_1 3 3)
		(rozmerySpalna_2 3 4)
		(rozmerySatnik 2 2)	
	)
	(byt
		(mesto Piestany)
		(cena 90000)
		(poschodie 2)
		(miestnosti kuchyna spalna_1 spalna_2 obyvacka)
		(rozmeryKuchyne 3 4)
		(rozmerySpalna_1 3 4)
		(rozmerySpalna_2 4 4)
	)
	(byt
		(mesto Puchov)
		(cena 72000)
		(poschodie 5)
		(miestnosti obyvacka spalna_1)
		(rozmeryObyvacky 5 6)
		(rozmerySpalna_1 3 4)
	)
	(byt
		(mesto Bratislava)
		(cena 98000)
		(poschodie 2)
		(miestnosti kuchyna obyvacka spalna_1 spalna_2 )
		(rozmeryKuchyne 4 4)
		(rozmeryObyvacky 4 4)
		(rozmerySpalna_1 3 3)
		(rozmerySpalna_2 3 4)
		)
)


(defrule B
(declare (salience 100))
(byt (mesto ?mesto)(cena ?cena)(poschodie ?poschodie) (miestnosti $?miestnosti))
=>
(bind ?x (length$  ?miestnosti))
(assert (kombi  ?cena ?x))
)



(defrule C
(declare (salience 90))
=>
(printout t "Zadaj cenu: " crlf)
(bind ?cena (read))
(printout t "Zadaj pocet miestnosti: " crlf)
(bind ?pocet (read))
(assert (chceny ?cena ?pocet))
)

(defrule D
(declare (salience 80))
(byt (mesto ?mesto)(cena ?cena)(poschodie ?poschodie))
(chceny ?c ?p)
(kombi  ?kc ?kp)
(test (eq ?cena ?c))
(test (eq ?p ?kp))
(test (eq ?cena ?kc))
=>
(printout t "Byt vhodny podla ceny je " ?mesto " a je za cenu " ?cena " a ma " ?kp " miestnosti "  crlf))


(defrule D
(declare (salience 80))
(byt (mesto ?mesto)(cena ?cena)(poschodie ?poschodie))
(chceny ?c ?p)
(test (eq ?cena ?c))
=>
(printout t "Byt vhodny podla ceny je " ?mesto " a je za cenu " ?cena crlf))




(defrule E
(declare (salience 70))
(byt (mesto ?mesto)(cena ?cena)(miestnosti $?miestnosti))
(test (member$ kuchyna $?miestnosti))
(test (member$ spalna_1 $?miestnosti))
(test (member$ spalna_2 $?miestnosti))
=>
(printout t "Byt, ktory ma kuchynu a 2 spalne je v " ?mesto " a je za cenu " ?cena crlf))










