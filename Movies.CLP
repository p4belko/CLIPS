(deftemplate film
	(slot nazov (type LEXEME))
	(slot rezia (type STRING))
	(slot rok (type INTEGER))
	(multislot herci (type STRING))
)

(deffacts filmy
	(film
		(nazov Janosik)
		(rezia "Pavol Bielik")
		(rok 1963)
		(herci "Stefan Kvietik" "Juraj Kukura" "Magda Vasaryova" "Emilia Vasaryova" "Frantisek Dibarbora" "Zuzana Kocurikova")
	)
	(film
		(nazov "Drak sa vracia")
		(rezia "Pavol Bielik")
		(rok 1971)
		(herci "Stefan Kvietik" "Magda Vasaryova" "Zdena Studenkova" "Katarina Kolnikova" "Vlado Muller")
	)
	(film
		(nazov "Dracie diery")
		(rezia "Marek Tapak")
		(rok 1975)
		(herci "Emilia Vasaryova" "Frantisek Dibarbora" "Juraj Kukura" "Vlado Muller")
	)
	(film
		(nazov Panelak)
		(rezia "Stefan Skrucany")
		(rok 2012)
		(herci "Zdena Studenkova" "Jozo Vajda" "Zuzana Kocurikova")
	)	
)

(defrule nacitaj-film
(declare (salience 100))	
=>
(printout t "zadajte nazov filmu" crlf)
(bind ?name (readline))
(printout t "zadajte meno rezisera" crlf)
(bind ?director (readline))
(printout t "zadajte mena hercov ako stringy" crlf)
(bind ?actors (readline))

(assert (film (rezia ?director) (nazov ?name) (rok 2000) (herci (explode$ ?actors))))
)

(defrule ulohaB
(film (nazov ?name) (rezia ?director) (rok ?year) (herci $?actors))
(test (> 2000 ?year))
(test (member$ "Magda Vasaryova" ?actors))
=>
(printout t "UlohaB: " ?name " " ?director " " ?year " " ?actors crlf)
)

(defrule ulohaC
(film (nazov ?name) (rezia ?director) (rok ?year) (herci $?actors))
(test (< 5 (length$ ?actors)))
=>
(printout t "UlohaC: " ?name " " ?director " " ?year " " ?actors crlf)
)