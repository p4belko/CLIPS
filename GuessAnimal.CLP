(defclass zviera
 (is-a USER))

(defclass cicavce
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default yes))
 (slot kojenie (default yes))
 (pattern-match reactive))

(defclass vtaky
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default yes))
 (slot vajcia (default yes))
 (slot kridla (default yes))
 (slot zobak (default yes))
 (pattern-match reactive))

(defclass plazy
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default yes))
 (slot vajcia (default yes))
 (slot supiny (default yes))
 (pattern-match reactive))

(defclass obojzivelniky
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default yes))
 (slot vajcia (default yes))
 (pattern-match reactive))

(defclass ryby
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default yes))
 (slot vajicka (default yes))
 (slot vodu (default yes))
 (slot supiny (default yes))
 (pattern-match reactive))

(defclass makkyse
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default no))
 (slot tvrdena-schranka (default yes))
 (pattern-match reactive))

(defclass ploskavce
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default no))
 (pattern-match reactive))

(defclass obruckavce
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default no))
 (slot cerv (default yes))
 (pattern-match reactive))

 (defclass clankonozce
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default no))
 (slot clanky (default yes))
 (pattern-match reactive))

 (defclass prhlivce
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default no))
 (slot voda (default yes))
 (slot regeneracia (default yes))
 (pattern-match reactive))

 (defclass ostnatokozce
 (is-a zviera)
 (role concrete)
 (slot chrbtica (default no))
 (slot voda (default yes)) 
 (slot ostne (default yes))
 (pattern-match reactive))

 
;;****************
;;* DEFFUNCTIONS *
;;****************

(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer)


(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then yes 
       else no))



;;;***************
;;;* QUERY RULES *
;;;***************

(defrule r-chrbtica ""
   (not (result ?))
   =>
   (assert (v-chrbtica (yes-or-no-p "Ma vase zviera chrbticu z kosti alebo chrupaviek?(yes/no)? "))))

(defrule r-vajicka ""
   (v-chrbtica yes)
   (not (result ?))
   =>
   (assert (v-vajicka (yes-or-no-p "Maju vajicka (yes/no)? "))))

(defrule r-kojenie ""
   (v-chrbtica yes)
   (v-vajicka no)
   (not (result ?))
   =>
   (assert (v-kojenie (yes-or-no-p "Krmia sa mladatá kojenim? (yes/no)? "))))

(defrule r-supiny ""
   (v-vajicka yes)
   (not (result ?))
   =>
   (assert (v-supiny (yes-or-no-p "Ma supiny?  (yes/no)? "))))

(defrule r-sus ""
   (v-supiny yes)
   (not (result ?))
   =>
   (assert (v-sus (yes-or-no-p "Zije toto zviera na susi?  (yes/no)? "))))

(defrule r-plutvy ""
   (v-sus no)
   (not (result ?))
   =>
   (assert (v-plutvy (yes-or-no-p "Ma plutvy?  (yes/no)? "))))

(defrule r-zobak ""
   (v-supiny no)
   (not (result ?))
   =>
   (assert (v-zobak (yes-or-no-p "Ma zobak?  (yes/no)? "))))

(defrule r-kridla ""
   (v-supiny no)
   (not (result ?))
   =>
   (assert (v-kridla (yes-or-no-p "Ma kridla?  (yes/no)? "))))




(defrule r-voda ""
   (v-chrbtica no)
   (not (result ?))
   =>
   (assert (v-voda (yes-or-no-p "Zije vo vode (yes/no)? "))))

(defrule r-regeneracia ""
   (v-voda yes)
   (not (result ?))
   =>
   (assert (v-regeneracia (yes-or-no-p "Ma lepsiu regeneraciu? (yes/no)? "))))

(defrule r-ostne ""
   (v-voda yes)
   (not (result ?))
   =>
   (assert (v-ostne (yes-or-no-p "Ma ostne? (yes/no)? "))))

(defrule r-clanky ""
   (v-voda no)
   (not (result ?))
   =>
   (assert (v-clanky (yes-or-no-p "Ma clanky? (yes/no)? "))))


(defrule r-cerv ""
   (v-clanky no)
   (not (result ?))
   =>
   (assert (v-cerv (yes-or-no-p "Vyzera ako cerv? (yes/no)? "))))

(defrule r-schranka ""
   (v-clanky no)
   (not (result ?))
   =>
   (assert (v-schranka (yes-or-no-p "Produkuje tvrdenu schranku? (yes/no)? "))))






;;;****************
;;;* RESULT RULES *
;;;****************

(defrule no-result ""
  (declare (salience -10))
  (not (result ?))
  =>
  (assert (result "Nepodarilo sa identifikovat druh zvierata."))
  (make-instance Tvor of zviera))

(defrule cicavec ""
   (v-chrbtica yes)
   (v-vajicka no)	
   (v-kojenie yes)
   (not (result ?))
   =>
   (make-instance Tvor of cicavce)
   (assert (result "Vas tvor je cicavec.")))


(defrule plaz ""
   (v-chrbtica yes)
   (v-vajicka yes)
   (v-supiny yes)	
   (v-sus yes)
   (not (result ?))
   =>
   (make-instance Tvor of plazy)
   (assert (result "Vas tvor je plaz.")))

(defrule ryba ""
   (v-chrbtica yes)
   (v-vajicka yes)
   (v-supiny yes)
   (v-sus no)
   (v-plutvy yes)	
   (not (result ?))
   =>
   (make-instance Tvor of ryby)
   (assert (result "Vas tvor je ryba.")))


(defrule obojzivelnik ""
   (v-chrbtica yes)
   (v-vajicka yes)
   (v-supiny no)	
   (v-zobak no)
   (not (result ?))
   =>
   (make-instance Tvor of obojzivelniky)
   (assert (result "Vas tvor je obojzivelnik.")))

(defrule vtak ""
   (v-chrbtica yes)
   (v-vajicka yes)
   (v-supiny no)
   (v-zobak yes)
   (v-kridla yes)	
   (not (result ?))
   =>
   (make-instance Tvor of vtaky)
   (assert (result "Vas tvor je vtak.")))



(defrule prhlivec ""
   (v-chrbtica no)
   (v-voda yes)
   (v-regeneracia yes)	
   (v-ostne no)	
   (not (result ?))
   =>
   (make-instance Tvor of prhlivce)
   (assert (result "Vas tvor je prhlivec.")))

(defrule ostnatokozec ""
   (v-chrbtica no)
   (v-voda yes)
   (v-regeneracia no)	
   (v-ostne yes)	
   (not (result ?))
   =>
   (make-instance Tvor of ostnatokozce)
   (assert (result "Vas tvor je ostnatokozec.")))


(defrule clankonozec ""
   (v-chrbtica no)
   (v-voda no)
   (v-clanky yes)	
   (not (result ?))
   =>
   (make-instance Tvor of clankonozce)
   (assert (result "Vas tvor je clankonozec.")))

(defrule obruckavec ""
   (v-chrbtica no)
   (v-voda no)
   (v-clanky no)		
   (v-cerv yes)	
   (not (result ?))
   =>
   (make-instance Tvor of obruckavce)
   (assert (result "Vas tvor je obruckavec.")))

(defrule makkys ""
   (v-chrbtica no)
   (v-voda no)
   (v-clanky no)		
   (v-cerv no)	
   (v-schranka yes)
   (not (result ?))
   =>
   (make-instance Tvor of makkyse)
   (assert (result "Vas tvor je makkys.")))




;;;********************************
;;;* STARTUP AND CONCLUSION RULES *
;;;********************************

(defrule star-rule ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Vitajte v programe na klasifikaciu zivocisnych druhov.")
  (printout t crlf crlf)
  (printout t "Pravdivo odpovedajte na otazky a program vypise druh Vasho zvierata a jeho atributy:")
  (printout t crlf crlf))



(defrule print-result ""
  (declare (salience 10))
  (result ?item)
  => 
  (printout t crlf crlf)
  (format t " %s%n%n%n" ?item)
  (printout t "OBJECT:" crlf)
  (send [Tvor] print)
  (printout t crlf crlf)
  (printout t "Koniec programu" crlf))