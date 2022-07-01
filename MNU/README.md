# MNU
Metody Numeryczne 2019

Program interpolujący - interpolacja Lagrange'a i Hermite'a
 
 # Opracowanie pytań

## 1. Rola przerwań w systemie operacyjnym

Przerwanie lub żądanie przerwania – sygnał powodujący zmianę przepływu sterowania, niezależnie od aktualnie wykonywanego programu. Pojawienie się przerwania powoduje wstrzymanie aktualnie wykonywanego programu i wykonanie przez procesor kodu procedury obsługi przerwania (ang. interrupt handler). Procedura ta wykonuje czynności związane z obsługą przerwania i na końcu wydaje instrukcję powrotu z przerwania, która powoduje powrót do programu realizowanego przed przerwaniem.

Dwa rodzaje przerwań:

- Zewnętrzne - sygnał pochodzi z zewnętrznego układu obsługującego przerwania sprzętowe, słuzy do komunikacji z urządzeniami zewnętrzymi np. klawiaturą
- Wewnętrzne - nazywane wyjątkami, zgłaszane przez procesor do sygnalizowania sytuacji wyjątkowych np. dzielenie przez zero

Zdarzenia powodujące przerwanie:

- Zakończenie operacji wejścia-wyjścia
- Dzielenie przez zero
- Niedozwolony dostęp do pamięci
- Zapotrzebowanie na usługę systemu

Mechanizm przerwań służy informowaniu o zdarzeniach zachodzących w urządzeniach wejścia/wyjścia. Typowe takie zdarzenia to zakończenie zleconej operacji wejścia/wyjścia oraz zdarzenia zewnętrzne, takie jak naciśnięcie klawisza na klawiaturze, ruch myszki, czy otrzymanie przez sieć pakietu danych. W momencie zajścia zdarzenia urządzenie generuje sygnał przerwania. W odpowiedzi na ten sygnał procesor przerywa wykonywanie aktualnie wykonywanego ciągu instrukcji, zapamiętuje na stosie systemowym adres określający gdzie przerwano wykonywanie instrukcji i wykonuje określoną procedurę obsługi przerwania. Po jej zakończeniu następuje powrót do przerwanego ciągu instrukcji. Przypomina to trochę wywołanie procedury, tyle że bodziec do wywołania procedury pochodzi z urządzenia wejścia/wyjścia, a nie z programu.

Zwykle procedura obsługi przerwania powinna mieć charakter atomowy, tzn. jej wykonanie nie powinno być przerywane, np. przez inne procedury obsługi przerwań. Nie można jednak zagwarantować, że w trakcie wykonywania procedury obsługi przerwania nie pojawi się żadne przerwanie sprzętowe. Dlatego też istnieje możliwość blokowania przerwań. Jeżeli przerwania są zablokowane, to obsługa pojawiających się przerwań sprzętowych jest odłożona do momentu odblokowania przerwań. Istnieje jednak wyjątek od tej zasady. Niektóre przerwania, tzw. przerwania nieblokowalne (niemaskowalne), sygnalizujące błędy krytyczne dla działania systemu komputerowego nie podlegają blokowaniu.

## 2. Planowanie przydziału procesora, wywłaszczanie procesu

W pamięciu operacyjnej znajduje się kilka procesów jednocześnie. Kiedy jakiś proces musi czekac, system operacyjny odbiera mu procesor i oddaje do dyspozycji innego procesu. Planowanie przydziału procesora jest podstawową funkcją kazdego systemu operacyjnego.

Komponenty jądra w planowaniu:

- Planista krótkoterminowy (ang. CPU scheduler) — wyznacza wartość priorytetu procesów gotowych i wybiera proces (o najwyższym priorytecie) do wykonania.
- Ekspedytor (zwany również dyspozytorem, ang. dispatcher) — realizuje przekazanie sterowanie do procesu wybranego przez planistę(dokonuje przełączenia kontekstu).

Ogólna koncepcja planowania:

- Tryb decyzji — określa okoliczności, w których oceniane i porównywane są priorytety procesów oraz dokonywany jest wybór procesu do wykonania.
- Funkcja priorytetu — funkcja wyznaczająca aktualny priorytet procesu na podstawie parametrów procesu i stanu systemu.
- Reguła arbitrażu — reguła rozstrzygania konfliktów w dostępie do procesora w przypadku procesów o tym samym priorytecie.

Tryb decyzji:

- Schemat niewywłaszczeniowy (ang. nonpreemptive) — proces po uzyskaniu dostępu do procesora wykonywany jest do momentu zakończenia lub zgłoszenia żądania obsługi do systemu.
- Schemat wywłaszczeniowy (ang. preemptive) — proces może zostać zatrzymany i umieszczony w kolejce procesów gotowych, a procesor zostaje przydzielony procesowi o wyższym (lub równym) priorytecie.

Podejmowanie decyzji o wywłaszczeniu:

- Utworzenie i przyjęcie nowego procesu
- Obudzenie procesu w wyniku otrzymania komunikatu, sygnału gotowości urządzenia (przerwanie) lub sygnału wynikającego z synchronizacji
- Upłynięcie kwantu czasu odmierzanego przez czasomierz
- Wzrost priorytetu innego procesu w stanie gotowy powyżej priorytetu procesu wykonywanego — możliwe w systemie ze zmiennymi priorytetami

## 3. Pamięć wirtualna i jej rola w systemie operacyjnym

Pamięć wirtualna – mechanizm zarządzania pamięcią komputera zapewniający procesowi wrażenie pracy w jednym, dużym, ciągłym obszarze pamięci operacyjnej podczas, gdy fizycznie może być ona pofragmentowana, nieciągła i częściowo przechowywana na urządzeniach pamięci masowej. Systemy korzystające z tej techniki ułatwiają tworzenie rozbudowanych aplikacji oraz poprawiają wykorzystanie fizycznej pamięci RAM w systemach wielozadaniowych.

Pamięć wirtualna oznacza oddzielenie pamięci fizycznej od pamięci logicznej dostępnej użytkownikowi. U podstaw tej idei leży obserwacja, że w każdej chwili tylko część pamięci procesu musi znajdować się w pamięci operacyjnej komputera - ta część, która akurat jest używana przez proces. Jest to możliwe dzięki temu, że procesy charakteryzują się lokalnością - w konkretnej chwili proces nie potrzebuje całej przydzielonej mu pamięci, a jedynie jej część. Pamięć logiczna może być więc większa niż fizyczna, wystarczy że nie używane w danej chwili obszary pamięci logicznej zostaną przeniesione na pamięć drugorzędną, np. na dysk. Taka pamięć drugorzędna używana do "udawania" pamięci operacyjnej jest nazywana obszarem wymiany.

Adresy w pamięci wirtualnej są odwzorowywane na adresy pamięci fizycznej, jednak przestrzeń adresów logicznych może być większa niż przestrzeń adresów fizycznych. Konstrukcja MMU musi być rozszerzona tak, żeby było wiadomo, czy dany adres logiczny odpowiada adresowi fizycznemu i jakiemu, a jeżeli nie, to jakiemu miejscu w obszarze wymiany odpowiada.

Mechanizm pamięci wirtualnej stanowi rozszerzenie mechanizmów stronicowania lub segmentacji, omówionych w poprzednim wykładzie. Są to, odpowiednio, mechanizmy stronicowania na żądanie albo segmentacji na żądanie. W przypadku segmentacji na żądanie, tablica segmentów tłumaczy numer segmentu na spójny obszar w pamięci fizycznej lub w obszarze wymiany. W przypadku stronicowania na żądanie, tablica stron tłumaczy numery stron na numery ramek lub numery bloków dyskowych w obszarze wymiany. Stronicowanie na żądanie jest dużo bardziej elastyczne niż segmentacja na żądanie, dlatego też w praktyce wyparło segmentację na żądanie. W dalszej części wykładu ograniczymy się do stronicowania na żądanie.

Mechanizm pamięci wirtualnej umożliwia też współdzielenie przestrzeni adresowej przez wiele procesów, oraz pozwala efektywniej tworzyć procesy.

## 4. Podstawy organizacji wejścia wyjścia. Obsługa urządzeń zewnętrznych przy użyciu aktywnego oczekiwania, przerwań i DMA.

#### Podstawy organizacji wejścia wyjścia

System operacyjny zlecając operację wejścia/wyjścia musi wiedzieć kiedy taka operacja zostanie wykonana. Stosowane są dwa rozwiązania:

- synchroniczne wykonywanie operacji wejścia/wyjścia procesor zleca wykonanie operacji i czeka, aż otrzyma potwierdzenie zakończenia operacji,
- asynchroniczne wykonywanie operacji wejścia/wyjścia procesor zleca wykonanie operacji, przerywa wykonywanie aktualnie wykonywanego zadania i nie czekając na zakończenie się operacji wejścia/wyjścia zaczyna wykonywać inne zadanie; po zakończeniu operacji wejścia/wyjścia urządzenie zewnętrzne generuje przerwanie, a procedura obsługi przerwania odnotowuje ten fakt.

Synchroniczne operacje wejścia/wyjścia są łatwiejsze do zaimplementowania, jednak operacje asynchroniczne pozwalają na zwiększenie wydajności systemu. W środowisku wieloprogramowym pozwalają one na równoczesne wykonywanie wielu operacji wejścia/wyjścia i obliczeń. Podobnie, jeżeli zadanie chce wykonać operację wejścia/wyjścia na urządzeniu, które aktualnie jest zajęte wykonywaniem innej operacji, to wykonanie takiego zadania jest wstrzymywane, aż do momentu, gdy dane urządzenie będzie dostępne i zlecona operacja zostanie wykonana. System operacyjny, który wykonuje operacje wejścia/wyjścia asynchronicznie musi pamiętać informacje o wszystkich wykonywanych i oczekujących operacjach wejścia/wyjścia. Informacje te są przechowywane w tablicy stanów urządzeń. Tablica ta zawiera po jednej pozycji dla każdego urządzenia w systemie. Jeżeli urządzenie nie wykonuje żadnej operacji wejścia/wyjścia, to odpowiadająca mu kolejka jest pusta. W przeciwnym przypadku, pierwsze zlecenie w kolejce odpowiada aktualnie wykonywanej operacji, a kolejne zlecenia odpowiadają operacjom oczekującym na wykonanie.

#### Układ DMA

W trakcie wykonywania asynchronicznej operacji wejścia/wyjścia następujące czynności zajmują czas pracy procesora: obsługa tablicy stanów urządzeń, zlecenie wykonania operacji sterownikowi urządzenia, przesłanie zapisywanych/odczytywanych danych, obsługa przerwania kończącego wykonanie operacji. Jeżeli zapisywane/odczytywane są pojedyncze znaki, tak jak w przypadku odczytywania znaków z klawiatury, to takie rozwiązanie jest akceptowalne. Jeśli jednak przesyłane są duże ilości danych, jak to ma miejsce w przypadku zapisu/odczytu z dysku, to procesor nie musi sam kopiować danych z/do pamięci operacyjnej do/z sterownika urządzenia. Może go w tym wyręczyć układ DMA (bezpośredniego dostępu do pamięci, ang. direct memory access), a procesor może w tym czasie wykonywać obliczenia. Układ DMA do przesyłania informacji potrzebuje oczywiście dostępu do magistrali systemowej. Korzysta z niej jednak w tych chwilach, gdy procesor z niej nie korzysta.

#### Aktywne oczekiwanie

Proces czekając na jakieś zdarzenie sprawdza ciągle warunek określający, czy dane zdarzenie już zaszło; jest to zjawisko niepożądane ze względu na niepotrzebne zużycie czasu procesora.

## 5. Systemy plików - rola i zasada działania (FAT, USF, EXT)

System plików to metoda przechowywania plików, zarządzania plikami, informacjami o tych plikach, tak by dostęp do plików i danych w nich zgromadzonych był łatwy dla użytkownika systemu. Z formalnego punktu widzenia system plików to reguły umieszczania na nośniku abstrakcyjnych danych oraz informacji umożliwiających przechowywanie tych danych, łatwy i szybki dostęp do informacji o danych oraz do tych danych, manipulowania nimi, a także sposobach usuwania ich.

Podstawowe funkcje systemu plików:

- otwieranie i zamykanie pliku
- tworzenie i usuwanie pliku
- tworzenie i usuwanie folderu
- odczyt i zapis do pliku

#### FAT (File Allocation Table)

Informacje na dysku ułożone są po kolei w jednostkach zwanych sektorami, ponieważ te dane często ulegają modyfikacjom, nie można sztywno przydzielać obszarów w których są składowane, trzeba wiec gdzieś pamiętać gdzie umieszczony jest ciąg dalszy pliku. Tę role pełni File Allocation Table (FAT) od której wzieła sie nazwa systemu plików.
Partycja jest podzielona na logiczne jednostki zwane klastrami (ang. clusters) Klaster odpowiada stałej ilośći sektorów, wielkość klastra zależy od wersji FAT-a, wacha sie pomiedzy 2kB a 32kB, zazwyczaj przy sektorach wielkosci 512B przypada 8 sektorów na klaster. Klaster jest przyporządkowany dokładnie jednemu plikowi, aczkolwiek jeden plik może być związany z kilkoma klastrami.
Poniższy rysunek przedstawia schemat budowy partycji FAT.

#### USF (Unix File System)

W Unixie i systemach opartych na nim, system plików jest centralną częscią systemu operacyjnego. Wszystkie dane w systemie unixowym są organizowane w pliki, a one w foldery. Te foldery są zorganizowane w strukturę przypominającą drzewo nazywaną systemem plików. Pliki zorganizowane są w wielopoziomową hierarchiczną strukturę znaną jako drzewo folderów. Na samym szczycie systemu plików znajduje się folder nazywany rootem, reprezentowany przez **/**, wszystkie pozostałe pliki są potomkami roota.

##### Typy plikow USF

- zwykłe pliki
- foldery
- pliki specjalne - reprezentujące urządzenie fizyczne
- potoki
- gniazda (sockets)
- linki symboliczne - referencja do innych plików

#### EXT (Extended File System)

Ext2, czyli Second Extended File System jest podstawowym i najszerzej używanym systemem plików dla Linuxa. Jest bardzo efektywny w typowych zastosowaniach, a równocześnie stosunkowo prosty. Jest uważany za jeden z najlepszych "standardowych" systemów plików.

- Zapewnia wszystkie elementy systemu plików Unix (dowiązania symboliczne, pliki specjalne, prawa dostępu...)
- Wysoka wydajność dzięki przeciwdziałaniu fragmentacji (poprzez przydzielanie bliskich bloków oraz prealokację).
- Wydajny mechanizm dowiązań symbolicznych (opisany niżej)
- Stabilny i dobrze przetestowany (sam system plików, jak również program naprawiający e2fsck)
- Dobrze zdefiniowany sposób dodawania rozszerzeń
- Niezależny od tworzącego systemu operacyjnego (wszystkie pola wielobajtowe zapisane w standardzie little-endian)
- Maksymalny rozmiar partycji to 4TB, a pojedynczego pliku 2GB. Maksymalna długość nazwy pliku: 255 znaków.
- Obsługa "dziurawych" plików (nieużywane bloki nie zostają przydzielone).

Partycja systemu plików Ext2 podzielona jest na bloki o rozmiarze 1024, 2048 lub 4096 bajtów (na niektórych architekturach do 8192 b). Kolejne bloki połączone są w grupy, których rozmiar zależy od wybranego rozmiaru bloku. Podział na grupy zwiększa lokalność danych związanych z jednym plikiem, a co za tym idzie, przyspiesza dostęp do nich. Grupy zostają ustalone statycznie podczas tworzenia systemu plików.

## 6. Przetwarzanie współbieżne - synchronizacja

Przetwarzanie współbieżne – przetwarzanie oparte na współistnieniu wielu wątków lub procesów, operujących na współdzielonych danych. Wątki uruchomione na tym samym procesorze są przełączane w krótkich przedziałach czasu, co sprawia wrażenie, że wykonują się równolegle. W przypadku procesorów wielordzeniowych lub wielowątkowych, możliwe jest faktycznie współbieżne przetwarzanie. Tego rodzaju przetwarzanie jest też możliwe w architekturach wieloprocesorowych. W takiej sytuacji wydajność poszczególnych wątków zasadniczo nie jest degradowana przez inne wątki, z wyjątkiem sytuacji kiedy wątki muszą rywalizować o wspólne zasoby, np. przepustowość magistral i urządzeń lub czas procesora, lub muszą synchronizować swoją pracę.

Przetwarzanie współbieżne znajduje szerokie zastosowanie w serwerach, które muszą obsługiwać liczne żądania od różnych klientów. Gdyby serwer działał sekwencyjnie, jedno duże żądanie sparaliżowałoby pracę serwera – pozostałe żądania czekałyby na swoją kolej, aż tamto zostanie ukończone. W architekturach jednowątkowych w celu zapobieżenia zatrzymaniu przetwarzania wątków przez duże zadanie, stosuje się technikę wywłaszczania i multitaskingu.

Jednoczesna praca na współdzielonych danych może doprowadzić do utraty ich spójności, dlatego konieczne jest stosowanie różnych mechanizmów synchronizacyjnych, np. semaforów i monitorów. Niektóre języki programowania (np. Go, Erlang, Ada, Rust) powstały z myślą o tworzeniu systemów współbieżnych i zawierają silne wsparcie dla komunikacji lub synchronizacji wątków już na poziomie języka.

##### Synchronizacja

Synchronizacja na najniższym poziomie polega na wykonaniu określonych (często specjalnych) instrukcji, które powodują zablokowanie postępu przetwarzania do czasu wystąpienia określonego zdarzenia w systemie, związanego również z instrukcją synchronizującą, ale w innym wątku.

Synchronizacja na wyższym poziomie polega na użyciu w programie specjalnych konstrukcji lub odpowiednim zdefiniowaniu struktur danych, które kompilator zamienia na właściwe instrukcje synchronizujące, udostępniane przez system operacyjny lub architekturę procesora.

- Celem synchronizacji jest kontrola przepływu sterowania pomiędzy procesami tak, żeby dopuszczalne stały się tylko przeploty instrukcji zgodne z intencją programisty.
- Synchronizacja na najniższym poziomie polega na wykonaniu specjalnych instrukcji, które powodują zatrzymanie postępu przetwarzania.
- Synchronizacja na wyższym poziomie polega na użyciu specjalnych konstrukcji programotwórczych lub odpowiednich definicji struktur danych.

## 7. Rola semaforów w systemie operacyjnym i zasada ich działania

Semafor – chroniona zmienna lub abstrakcyjny typ danych, który stanowi klasyczną metodę kontroli dostępu przez wiele procesów do wspólnego zasobu w środowisku programowania równoległego.

Wyobraźmy sobie wielotorową magistralę kolejową, która na pewnym odcinku zwęża się do k torów. Pociągi jeżdżące magistralą to procesy. Zwężenie to uogólnienie sekcji krytycznej. Na zwężonym odcinku może znajdować się na raz maksymalnie k pociągów, każdy na oddzielnym torze. Podobnie jak w przypadku sekcji krytycznej, każdy oczekujący pociąg powinien kiedyś przejechać i żaden pociąg nie powinien stać, jeżeli jest wolny tor. Semafor to specjalna zmienna całkowita, początkowo równa k. Specjalna, ponieważ (po zainicjowaniu) można na niej wykonywać tylko dwie operacje:

- **P** - Jeżeli semafor jest równy 0 (semafor jest opuszczony), to proces wykonujący tę operację zostaje wstrzymany, dopóki wartość semafora nie zwiększy się (nie zostanie on podniesiony). Gdy wartość semafora jest dodatnia (semafor jest podniesiony), to zmniejsza się o 1 (pociąg zajmuje jeden z k wolnych torów).
- **V** - Wartość semafora jest zwiększana o 1 (podniesienie semafora). Jeżeli jakiś proces oczekuje na podniesienie semafora, to jest on wznawiany, a semafor natychmiast jest zmniejszany.

Istotną cechą operacji na semaforach jest ich niepodzielność. Jeżeli jeden z procesów wykonuje operację na semaforze, to (z wyjątkiem wstrzymania procesu, gdy semafor jest opuszczony) żaden inny proces nie wykonuje w tym samym czasie operacji na danym semaforze. Aby zapewnić taką niepodzielność, potrzebne jest specjalne wsparcie systemowe lub sprzętowe.

## 8. Problem sekcji krytycznej i jej rozwiązanie przy użyciu semafora

Sekcja krytyczna, to fragment(y) kodu lub operacje, które nie mogą być wykonywane współbieżnie. Sekcja krytyczna jest otoczona dodatkowym kodem synchronizującym przebywanie procesów wejściowych -- przed wejściem do sekcji krytycznej każdy proces musi przejść przez sekcję wejściową, a wychodząc przechodzi przez sekcję wyjściową. Dopóki jakiś proces przebywający w sekcji krytycznej nie opuści jej, inne procesy chcące wejść do sekcji krytycznej są wstrzymywane w sekcji wejściowej. Przechodząc przez sekcję wyjściową, proces opuszczający sekcję krytyczną wpuszcza jeden z procesów oczekujących (jeśli takowe są). Zakładamy tutaj, że każdy proces, który wejdzie do sekcji krytycznej kiedyś ją opuści.

Rozwiązanie problemu sekcji krytycznej za pomocą semaforów jest banalnie proste. Wystarczy dla każdej sekcji krytycznej utworzyć odrębny semafor, nadać mu na początku wartość 1, w sekcji wejściowej każdy proces wykonuje na semaforze operację P, a w sekcji wyjściowej operację V. Wymaga to jednak od programisty pewnej dyscypliny: Każdej operacji P musi odpowiadać operacja V i to na tym samym semaforze. Pomyłka może spowodować złe działanie sekcji krytycznej.

Semafory są tak często stosowane do rozwiązywania problemu sekcji krytycznej, że spotyka się ich uproszczoną wersję: semafory binarne. Semafor binarny, to taki semafor, który może przyjmować tylko dwie wartości: 0 i 1. Próba podniesienia semafora równego 1, w zależności od implementacji, nie zmienia jego wartości lub powoduje błąd.

## 9. Model sieci ISO-OSI i stos TCP/IP

Wzajemna komunikacja urządzeń w sieci komputerowej składa się z kilku etapów, z kilku elementów. Każdy z nich jest tak samo ważny, ponieważ na każdym z nich realizowane są zadania niezbędne do poprawnej komunikacji. Etapy te określone są przez tak zwane modele warstwowe. Istnieją dwa warstwowe modele, są nimi model protokołów TCP/IP oraz model odniesienia ISO/OSI.

Model TCP/IP określany jest jako model protokołów. Każda z jego warstw wykonuje konkretne zadania, do realizacji który wykorzystywane są konkretne protokoły. Model ISO/OSI natomiast zwany modelem odniesienia, stosowany jest raczej do analizy, która pozwala lepiej zrozumieć procesy komunikacyjne zachodzące w sieci oraz stanowi wzór do projektowania rozwiązań sieciowych zarówno sprzętowych jak i programowych.

#### ISO/OSI

Według modelu OSI każdy protokół komunikuje się ze swoim odpowiednikiem, będącym implementacją tego samego protokołu w równorzędnej warstwie komunikacyjnej systemu odległego. Dane przekazywane są od wierzchołka stosu, poprzez kolejne warstwy, aż do warstwy fizycznej, która przesyła je poprzez sieć do odległego hosta.

Model ISO/OSI (Open System Interconnection Reference Model) składa się z 7 warstw:

- aplikacji - pozwala użytkownikom końcowym korzystać z aplikacji sieciowych
- prezentacji - przekazuje do warstwy aplikacji informacje o zastosowanym formacie danych, np. informuje jakie typy plików będą przesyłane, odpowiada równiez za za odpowiednie zakodowanie danych na urządzeniu źródłowym i dekodowanie na docelowym
- sesji - zarządza sesjami użytkowników korzystających np. ze stron WWW lub komunikacji wideo
- transportu - zapewnia sprawną komunikację między urządzeniami
- sieci - odpowiedzialna za adresowanie i wyznaczanie najlepszej ściezki przesyłu danych
- łącza danych - główne zadanie to kontrola dostępu do medium transmisyjnego, a takze adresowanie danych
- fizyczna - odpowiedzialna za kodowanie danych do postaci czystych bitów i przesyłanie ich poprzez medium transmisyjne do odpowiednich urządzeń

#### TCP/IP

Podstawowym założeniem modelu TCP/IP jest podział całego zagadnienia komunikacji sieciowej na szereg współpracujących ze sobą warstw . Każda z nich może być tworzona przez programistów zupełnie niezależnie, jeżeli narzucimy pewne protokoły według których wymieniają się one informacjami. Założenia modelu TCP/IP są pod względem organizacji warstw zbliżone do modelu OSI. Jednak liczba warstw jest mniejsza i bardziej odzwierciedla prawdziwą strukturę Internetu.

Model TCP/IP (Transmission Control Protocol/Internet Protocol) składa się z 4 warstw:

- Warstwa aplikacji - udostępnia uzytkownikom mozliwosc korzystania z usług sieciowych, takich jak WWW, poczta elektroniczna, wymiana plików, czy komunikatory. Jest to warstwa najblizsza uzytkownikowi.
- Warstwa transportu - główne zadanie to sprawna obsługa komunikacji między urządzeniami. W tej warstwie dane są dzielone na mniejsze części
- Warstwa internetowa - główne zadanie to odnalezienie najkrótszej i najszybszej drogi do urządzenia docelowego, ale tez adresowanie danych z wykorzystaniem adresów logicznych (adresów IP)
- Warstwa dostępu do sieci - koduje dane do postaci czystych bitów i przekazuje do medium transmisyjnego, a takze je adresuje wykorzystując adresy fizyczne (adresy MAC)

## 10. Protokół Ethernet

Ethernet – technika, w której zawarte są standardy wykorzystywane w budowie głównie lokalnych sieci komputerowych. Obejmuje ona specyfikację przewodów oraz przesyłanych nimi sygnałów. Ethernet opisuje również format ramek i protokoły z dwóch najniższych warstw Modelu OSI.

Ethernet to cały zbiór rozwiązań sieciowych, które implementowane są zarówno w warstwie łącza danych, jak również w warstwie fizycznej. Pieczę nad rozwojem tej technologii sprawuje obecnie organizacja IEEE (ang. Institute of Electrical and Electronics Engineers), która w 1985 roku opublikowała jej standardy i opisała je numerem 802.2 oraz 802.3. Standard 802.2 odnosi się do funkcji związanych z podwarstwą LLC, ten drugi natomiast do podwarstwy MAC oraz do warstwy fizycznej modelu OSI.

Cechy Ethernet

- Węzły w sieci współdzielą medium transmisyjne
- Sygnał jest przesyłany szeregowo i trafia do wszystkich kart sieciowych
- Jednakowe prawo rozpoczęcia transmisji (rywalizacja o dostęp)
- Mozliwośc nadawania jednego węzła w tym samym czasie (kolizje)

Na sukces rozwiązań opartych na standardzie Ethernet składa się wiele czynników, m. in.:

- łatwość implementacji
- niezawodność
- zdolność do przyjmowania nowych technologii
- stosunkowo niewielki koszt implementacji

## 11. Podstawowe protokoły i usługi sieciowe – ARP, DHCP, DNS, HTTP, FTP, SMTP, IMAP, POP3, SSH

## ARP

Address Resolution Protocol to mechanizm pozwalający na odwzorowanie adresu logicznego, czyli IP na adres fizyczny, czyli MAC. Załóżmy, że komputer chcąc przesłać dane do innego urządzenia zna jego adres IP, ale nie zna adresu MAC. Aby ten adres poznać, komputer będący nadawcą danych, zanim te konkretne dane wyśle, tworzy rozgłoszeniową ramkę ARP, która rozsyłana jest do wszystkich urządzeń w tej samej sieci. W polu adresu źródłowego takiej ramki zapisywany jest adres komputera, który przygotował taką ramkę, a w polu adresu docelowego, rozgłoszeniowy adres MAC: FF-FF-FF-FF-FF-FF.

## DHCP

DHCP jest to protokół działający jako usługa, a nie jako program czy aplikacja. DHCP umożliwia podłączonym do sieci komputerom pobieranie adresu IP, maski podsieci, adresu bramy i serwera DNS oraz innych ustawień ze skonfigurowanej wcześniej puli adresów. Przydzielanie adresów komputerom klienckim poprzez usługę DHCP, zwane przydzielaniem dynamicznym, przypisuje adres IP w dzierażawe na czas ustalony przy konfiguracji DHCP.

## DNS

DNS to protokół, usługa, zamieniająca nazwy domenowe, zrozumiałe dla człowieka na adresy IP urządzeń w sieci. Posiada baze rekordów, w której wyszukane są odpowiednie adresy na podstawie nazw domenowych.
Hierarchia serwerów DNS ta ma postać odwróconego drzewa, gdzie korzeń, czyli serwery DNS głównego poziomu znajdują się na samej górze. Serwery głównego poziomu przechowują informację jak dotrzeć do serwerów najwyższego poziomu, to z kolei przechowują informację jak dotrzeć do serwerów drugiego poziomu itd. Domeny najwyższego poziomu określają kraj (.pl .de czy .uk) lub też typ organizacji ( .org .com czy .gov).

## HTTP

Hypertext Transfer Protocol - używany w oknie przeglądarki, poprzedzający adres strony internetowej. Pozwala on na komunikację klient – serwer. Hypertext Transfer Protocol określa w jaki sposób treści są udostępniane, przekształcane i w jaki sposób ma je odczytać serwer. Protokół http nazywany jest bezstanowym. Oznacza to, że nie przechowuje on żadnych danych. Zaletą jest fakt, że nie przeciąża tym samym serwerów, jednak stanowi mniejsze bezpieczeństwo. Przy tym protokole używane są cookies, które pozwalają śledzić poczynania internautów odwiedzających nasze serwisy. Wykorzystywany jest już od roku 1990. Protokół wpływa znacząco na bezpieczeństwo w sieci, ale także pełni istotna rolę w pozycjonowaniu.

## FTP

File Transfer Protocol – to protokół typu klient-serwer. Oznacza to, że klient prosi o pliki, a serwer mu je dostarcza. FTP potrzebuje więc dwóch podstawowych kanałów do nawiązania połączenia: kanału poleceń (inicjuje on instrukcję, przekazuje podstawowe informacje, tzn. które pliki mają być udostępnione) oraz kanału danych (przesyła on dane pliku między dwoma urządzeniami). FTP ma jednak jedną istotą wadę, a jest nią brak bezpieczeństwa. FTP został wynaleziony w latach siedemdziesiątych ubiegłego stulecia. Dodatkowo transfery FTP nie są szyfrowane, co oznacza, że Twoje hasła, nazwy użytkownika czy inne dane wrażliwe są podatne na ataki.

## SMTP

Simple Mail Transfer Protocol - jest używany do wysyłania wiadomości e-mail, a nie synchronizacji folderów pocztowych (pobierania wiadomości ze skrzynki e-mail serwera). Ponieważ protokół SMTP opiera się wyłącznie o możliwość przesłania prostego tekstu, jego działanie wsparto dodatkowym standardem MIME który definiuje budowę w tym formatowanie wiadomości e-mail.

## IMAP

Internet Message Access Protocol - jest protokołem poczty, który odpowiada za synchronizację oraz odbieranie wiadomości e-mail. Jest następncą protokołu POP3. Jego główną zaletą jest możliwość synchronizacji wszystkich folderów wiadomości, między różnymi programami pocztowymi oraz urządzeniami mobilnymi. Oznacza to, że wiadomość e-mail pobierana z serwera nie jest automatycznie z niego usuwana. Łącząc się z serwerem poczty przez protokół IMAP, możesz łatwo i szybko pobierać jedynie nagłówki wiadomości e-mail i wybrać te treści, które będą przeniesione na Twój komputer lokalny.

## POP3

Post Office Protocol to potoczna nazwa serwera poczty przychodzącej. W odniesieniu do programów pocztowych, zapewnia komunikację między fizycznie zlokalizowaną na hostingu skrzynką e-mail, a programem, łącząc i pozwalając pobrać wiadomości na urządzenie. Protokół POP3 nie zapewnia synchronizacji folderów, co oznacza, że wiele folderów dostępnych na skrzynce e-mail nie będzie widocznych i obsługiwanych w programie pocztowym. Podczas pobierania maili korzystając z POP3 automatycznie pobierasz wszystkie nieodebrane wiadomości wraz z ich treścią oraz załącznikami.

## SSH

Secure Shell to protokół zdalnego zarządzania hostami. Domyślnym algorytmem szyfrowania komunikacji jest algorytm RSA. Podczas instalacji serwera SSH tworzona jest para kluczy – klucz publiczny i prywatny serwera – służą one do szyfrowania i deszyfrowania komunikacji. Podczas pierwszego połączenia z serwerem, klient, zapisuje publiczny klucz serwera na swoim dysku, w pliku known_hosts. Następnie tworzy tak zwany klucz sesji, który będzie stosowany do szyfrowania całej komunikacji. Klucz sesji zostaje zaszyfrowany kluczem publicznym otrzymanym wcześniej od serwera i jest do niego odsyłany. Od tego momentu cała komunikacja szyfrowana jest kluczem sesji. Standardowo SSH działa na porcie 22.

## 12. Pojecie relacyjnej bazy danych

Relacyjna baza danych to rodzaj bazy danych, który pozwala przechowywać powiązane ze sobą elementy danych i zapewnia do nich dostęp. Relacyjne bazy danych są oparte na modelu relacyjnym (Model relacyjny bazuje na matematycznym pojęciu relacji) — jest to prosty i intuicyjny sposób przedstawiania danych w tabelach. 

W relacyjnych bazach danych mamy trzy rodzaje relacji: 
- Jeden do Jednego / One to One - Każdemu rekordowi z pierwszej tabeli może odpowiadać tylko jeden rekord z drugiej tabeli i każdemu rekordowi z drugiej tabeli może odpowiadać tylko jeden rekord z pierwszej tabeli
- Jeden do wielu / One to Many - Każdemu rekordowi z pierwszej tabeli może odpowiadać najwyżej jeden rekord z drugiej tabeli, a każdemu rekordowi z drugiej tabeli może odpowiadać wiele rekordów z pierwszej tabeli 
- Wiele do wielu / Many to Many - Każdemu rekordowi z pierwszej tabeli może odpowiadać wiele rekordów z drugiej tabeli i każdemu z rekordów z drugiej tabeli może odpowiadać wiele rekordów z pierwszej tabeli. Najpopularniejszym sposobem rozwiązywania relacji wiele do wielu jest tworzenie tabeli pośredniej. Dzięki temu, zamiast jednej skomplikowanej relacji wiele do wielu, tworzymy dwie relacje jeden do wielu.

## 13. Normalizacja bazy danych

Normalizacja to bezstratny proces organizowania danych w tabelach mający na celu zmniejszenie ilości danych składowanych w bazie oraz wyeliminowanie potencjalnych anomalii

#### 1 Postać normalna

Pierwsza postać normalna to podstawa baz – mówi o atomowości danych. Czyli tabela (encja) przechowuje dane w sposób atomowy. Każde pole przechowuje jedną informację, dzięki czemu możemy dokonywać efektywnych zapytań.
Mówimy, że tabela (encja) jest w pierwszej postaci normalnej, kiedy wiersz przechowuje informacje o pojedynczym obiekcie, nie zawiera kolekcji, posiada klucz główny (kolumnę lub grupę kolumn jednoznacznie identyfikujących go w zbiorze) a dane są atomowe.

#### 2 Postać normalna

Mówi o tym, że każda tabela powinna przechowywać dane dotyczące tylko konkretnej klasy obiektów.
Jeśli mówimy o encji (tabeli) np. Klienci, to wszystkie kolumny opisujące elementy takiej encji, powinny dotyczyć Klientów a nie jakiś innych obiektów (np. ich zamówień).

#### 3 Postać normalna

Trzecia postać normalna głosi, że kolumna informacyjna nie należąca do klucza nie zależy też od innej kolumny informacyjnej, nie należącej do klucza. Czyli każdy niekluczowy argument jest bezpośrednio zależny tylko od klucza głównego a nie od innej kolumny.
W skrócie oznacza to, że jeżeli mamy np kolumny, które da się wyliczyć na podstawie innych kolumn, to lepiej je wyliczać w zapytaniach, a nie trzymać w bazie.

https://www.sqlpedia.pl/projektowanie-i-normalizacja-bazy-danych/

## 14. Rola i budowa indeksów w bazach danych

Indeks jest pomocniczą strukturą używaną w celu przyspieszenia dostępu do żądanych rekordów pliku. Konstruowany jest w oparciu o pole indeksujące.

Indeks tworzymy na kolumnach, które:

- mają wysoką selektywność (tzn. mają dużą liczbę unikalnych wartości dla kolumny)
- są często przeszukiwane, a rzadko modyfikowane
- są wykorzystywane do łączenia tabel

Zatem w praktyce utworzymy indeks dla kolumn:

- z ograniczeniem PRIMARY KEY, UNIQUE
- z ograniczeniem FOREIGN KEY oraz kolumn wykorzystywanych przy łączeniu tabel (JOIN)
- wykorzystywanych w klauzuli WHERE do wyszukiwania wartości pojedynczych lub przedziałów
- wykorzystywanych w ORDER BY i GROUP BY

#### Indeksy grupujące (CLUSTERED)

Indeks grupujący porządkuje tabelę fizycznie według klucza indeksu (tabela staje się indeksem).
Na tabeli może zatem istnieć tylko jeden indeks grupujący.
Indeks grupujący tworzony jest domyślnie na kluczu podstawowym, ale może być alternatywnie założony na innych kolumnach (wówczas klucz podstawowy oparty jest o indeks niegrupujący).

#### Indeksy niegrupujące (UNCLUSTERED)

Indeks niegrupujący jest osobnym obiektem w bazie danych. Można założyć wiele indeksów niegrupujących na tabeli

#### Indeks zawierający/pokrywający zapytanie (COVERING INDEX)

Mówimy, że indeks zawiera (pokrywa) zapytanie, jeżeli zawiera wszystkie atrybuty użyte w zapytaniu (aby wykonać zapytanie wystarczy odwołanie do indeksu, niepotrzebne jest odwołanie do tabeli). Patrz niżej - opcja INCLUDE.

## 15. Diagram związków encji (ERD)

Diagram związków encji – ERD (Entity Relationship Diagram)
Diagram ERD to rodzaj graficznego przedstawienia związków pomiędzy encjami używany w projektowaniu systemów informacyjnych. Zawiera:

- Encje
- Atrybuty
- Związki

## 16. Transakcje w bazach danych, zasada ACID, anomalie, poziomy izolacji

Transakcja to zbiór operacji na bazie danych, które stanowią pewną całość. Powinny zostać wykonane wszystkie albo ̇zadna z nich. Nie ma mowy o częściowym wykonaniu.
Transakcja składa się z szeregu poleceń SQL traktowanych jako całość

Transakcja zatem musi posiadać własności ACID

**Własności ACID**

- **Atomowość** (atomicity) – czyli: wszystko albo nic; każda transakcja stanowi pojedynczą i niepodzielną jednostkę przetwarzania (a także odtwarzania) – w transakcji nie ma więc podtransakcji. Każda transakcja jest bądź wykonana w całości, bądź też żaden jej efekt nie jest widoczny w bazie danych.
- **Spójność** (consistency) – transakcja rozpoczyna się w spójnym stanie bazy danych i pozostawia bazę danych w stanie spójnym (tym samym lub innym). Jeśli transakcja narusza warunki spójności bazy danych, to zostaje odrzucona.
- **Odizolowanie** (isolation) – zmiany wykonywane przez transakcję nie zatwierdzoną nie są widziane przez inne transakcje (chyba, że przyjęty poziom izolacji na to zezwala).
- **Trwałość** (durability) – zmiany w bazie danych dokonane przez transakcję zatwierdzoną są trwałe w bazie danych, tzn. nawet w przypadku awarii systemu musi istnieć możliwość ich odtworzenia.

**Anomalie**

- Utracony odczyt (lost update)
- Brudne czytanie (dirty reads) - Anomalia pojawia się dlatego, że transakcja czyta „brudne” (niezatwierdzone) dane z innej transakcji i zostaje zatwierdzona przed transakcją, z której czytała
- Powtórne czytanie (repeatable reads) - Powodem występowania anomalii powtórnego czytania jest to, że dopuszczalne jest zapisywanie w niezatwierdzonych transakcjach.
- Fantomy (phantom reads)

**Poziomy izolacji**

- Poziom 0 – READ UNCOMMITTED - Na tym poziomie izolacji możliwe jest tworzenie historii przetwarzania ze wszystkimi anomaliami poza utraconą modyfikacją – występuje zatem brak odtwarzalności, anomalia powtórnego czytania i fantomów
- Poziom 1 – READ COMMITTED - domyślny poziom izolacji w SQL Server. Poziom ten eliminuje problem brudnego czytania (nieodtwarzalności), pozostaje jednak anomalia powtórnego czytania i fantomów
- Poziom 2 – REPEATABLE READ - Na tym poziomie występuje tylko anomalia fantomów
- Poziom 3 – SERIALIZABLE - jedyny poziom, na którym transakcje są w pełni szeeregowalne. Nie występują tu żadne anomalie, ale poziom współbieżności jest najmniejszy

Im wyższy poziom izolacji transakcji (konfliktowości) tym niższa współbieżność, a więc dłuższy czas wykonywania transakcji, ale jednocześnie tym większa niezawodność przetwarzania oraz jego bezpieczeństwo z punktu widzenia zachowania spójności bazy danych.

https://eduwiki.wmi.amu.edu.pl/ania/DBADLN0UN0?action=AttachFile&do=view&target=Bazy+danych+Wyklad+12+-+Transakcje+Podstawy.pdf

## 17. Podstawowe konstrukcje języka SQL

SQL to strukturalny język zapytań (ang. Strucured Query Language). Jest to najbardziej rozpowszechniony standaryzowany język dostępu do systemów zarządzania relacyjnymi bazami danych.

SQL jest językiem strukturalnym, zdefiniowanym za pomocą reguł składniowych. Występują w nim trzy rodzaje poleceń.

<ul>
<li> <b>DDL</b> (Data Definition Language) – język definiowania baz danych. Język DDL jest przeznaczony do tworzenia nowych baz danych.</li >
<ul>
<li>CREATE (np. CREATE TABLE, CREATE DATABASE, ...) – utworzenie struktury (bazy, tabeli, indeksu itp.)</li>
<li>DROP (np. DROP TABLE, DROP DATABASE, ...) – usunięcie struktury</li>
<li>ALTER (np. ALTER TABLE ADD COLUMN ...) – zmiana struktury (dodanie kolumny do tabeli, zmiana typu danych w kolumnie tabeli)</li>
</ul>
<li><b>DML</b> (Data Manipulation Language) – język manipulowania danymi. Polecenia SQL odpowiadające językowi DML są znacznie częściej wykorzystywane gdyż realizują one funkcje zapisywania i wyszukiwania rzeczywistych danych z baz danych.
<ul>
<li>SELECT – pobranie danych z bazy</li>
<li>INSERT – umieszczenie danych w bazie</li>
<li>UPDATE – zmiana danych</li>
<li>DELETE – usunięcie danych z bazy</li>
</ul>
<li><b>DCL</b> (Data Control Language) – służy ona do zapewnienia bezpieczeństwa dostępu do danych znajdujących się w bazie. Za jego pomocą można na przykład nadawać czy odbierać uprawnienia poszczególnym użytkownikom czy całym grupom.</li>
<ul>
<li>GRANT (np. GRANT ALL PRIVILEGES ON EMPLOYEE TO PIOTR WITH GRANT OPTION) – przyznanie wszystkich praw do tabeli EMPLOYEE użytkownikowi PIOTR z opcją pozwalającą mu nadawać prawa do tej tabeli.</li>
<li>REVOKE – odebranie użytkownikowi wszystkich praw do tabeli, które zostały przyznane poleceniem GRANT</li>
<li>DENY</li>
</ul>
</ul>

## 18. Zasada działania asymetrycznych algorytmów szyfrujących, przykłady.

Szyfry asymetryczne są nazywane również szyframi z kluczem publicznym i prywatnym. W swoim działaniu wykorzystują dwa klucze, jeden do szyfrowania wiadomości, a drugi do deszyfrowania.
System szyfrowania asymetrycznego składa się z trzech algorytmów (G, E, D):

- **G()** - niedeterministyczny algorytm zwracający parę kluczy (pk, sk),
- **E(pk, m)** - niedeterministyczny algorytm szyfrujący tekst jawny _m_ i zwracający tekst zaszyfrowany c,
- **D(sk,c)** - deterministyczny algorytm deszyfrujący c, zwracający tekst jawny m.

Wszystkie trzy algorytmy muszą spełniać regułę konsystencji, czyli dla każdej pary kluczy **(pk, sk)** zwróconej przez G i dla każdej wiadomości jawnej m musi zachodzić warunek: **D(sk, E(pk, m)) = m**

Klucz publiczny jest znany powszechnie i może być używany przez wszystkich zainteresowanych do szyfrowania dowolnie wybranych danych. Idea szyfrów asymetrycznych polega na tym, że tylko posiadacz drugiego klucza z pary - klucza prywatnego (który nie jest publicznie znany), może rozszyfrować takie dane.

#### Przykłady:

- Protokół Diffiego - Hellmana
  Algorytm protokołu Diffiego-Hellmana przedstawia sposób komunikacji pomiędzy dwoma zainteresowanymi stronami, która umożliwia ustalenie współdzielonego sekretnego klucza. Następnie klucz ten może być używany podczas dalszej komunikacji, chronionej przy użyciu szyfrowania symetrycznego.
- RSA
  Algorytm RSA umożliwia utworzenie dwóch powiązanych kluczy: publicznego oraz prywatnego, a następnie wykorzystywanie ich w celu ochrony treści przekazywanych wiadomości. Klucz publiczny jest powszechnie znany i każdy może za jego pomocą zaszyfrować dowolną wiadomość. Natomiast jedynie posiadacz klucza prywatnego może odszyfrować otrzymane szyfrogramy.
  Analogicznie, posiadacz klucza prywatnego może używać go do szyfrowania danych, pozwalając w ten sposób każdemu posiadaczowi odpowiadającego mu klucza publicznego odszyfrować je.
  http://www.crypto-it.net/pl/asymetryczne/index.html

## 19. Rola inżynierii oprogramowania

Inżynieria oprogramowania jest dziedziną inżynierii, która kompleksowo obejmuje wszelkie aspekty tworzenia oprogramowania – od fazy pierwszej, czyli planowania, analizowania, a także określenia wymagań przez omówienie szczegółów projektowania i wdrażania po nanoszenie poprawek i etapy rozwojowe.
W inżynierii oprogramowania wyróżnia się od kilku do nawet kilkunastu etapów w procesie jego produkcji, w zależności od potrzeb. Typowym podstawowo istniejącym podziałem jest:

- **specyfikacja** – określenie i ustalenie wymagań, które musi spełniać oprogramowanie
- **projektowanie** – ustalenie ogólnej architektury systemu, wymagań dla poszczególnych jego składowych
- **implementacja** – realizacja ustalonej architektury poprzez implementację jego składowych (modułów) i połączeń między nimi
- **integracja** – zintegrowanie poszczególnych składowych w jeden system, testowanie całego systemu
- **ewolucja** – uruchomienie systemu, usuwanie wykrytych podczas jego używania błędów, rozszerzanie systemu

## 20. Modele cyklu życia oprogramowania

<ul>
<li>Model kaskadowy (waterfall)</li>
W modelu kaskadowym kolejne etapy procesu rozwoju oprogramowania następują po sobie w ściśle określonym porządku:
<ul>
<li>Określenie wymagań (requirements)</li>
<li>Projektowanie systemu (system design)</li>
<li>Implementacja i testowanie modułów (podsystemów)</li>
<li>Testowanie połączeń modułów i całości systemu</li>
<li>Użytkowanie i pielęgnacja (konserwacja, maintenance)</li>
</ul>
Każda następna faza rozpoczyna się dopiero po (często formalnym) zakończeniu fazy poprzedzającej
<li>Model ewolucyjny</li>
Celem modelu ewolucyjnego jest poprawienie modelu kaskadowego poprzez rezygnację ze ścisłego, liniowego następstwa faz.
Pozostawia się te same czynności, ale pozwala na powroty, z pewnych faz do innych faz poprzedzających
<li>Model prototypowy</li>
Prototyp - niepełny system, spełniający cześć wymagań, przeznaczonym do przetestowania rozwiązań wykorzystanych do jego wytworzenia.
Produkt finalny może być (z zasady jest) różny od prototypu. Z założenia prototyp nie wchodzi w skład ostatecznego systemu.
Ostateczny system budowany jest od podstaw po zaakceptowaniu rozwiązań zastosowanych w prototypie.
<li>Model spiralny</li>
Model ten łączy cechy modelu kaskadowego oraz prototypowego. Proces ten ma postać spirali, w której każda pętla przedstawia kolejne fazy procesu. Każda faza składa się z czterech etapów.
<ul>
<li>Ustalenie celów</li>
<li>Rozpoznanie i redukcja zagrożeń</li>
<li>Tworzenie i testowanie</li>
<li>Planowanie następnej iteracji</li>
</ul>
</ul>

## 21. Zakres projektu oraz wymagania funkcjonalne i niefunkcjonalne

Zakres projektu jest to możliwie jak najdokładniejsze i całkowite określenie oczekiwanego wyniku projektu.
Zakres nigdy nie określa konkretnych zadań mających na celu realizację projektu. Odpowiada na pytanie, co powinno być zrobione w projekcie, aby osiągnąć jego cele.
Wymagania funkcjonalne to konkretne aspekty funkcjonalności aplikacji, które definiują działania, które mogą być udostępniane dla użytkownika czy samego oprogramowania. Ich specyfikacja jest jednym z kluczowych punktów inicjowania projektu, gdyż dobrze zdefiniowane i opisane wymagania mogą znacznie uprościć implementację oraz analizę wprowadzanych modyfikacji.
Wymagania niefunkcjonalne opisują ograniczenia, przy zachowaniu których system powinien realizować swoje funkcje. Mogą być związane z właściwościamy systemu, jak np. czas reakcji, niezawodność. Mogą definiować ograniczenia systemu.

## 22. Przypadki użycia - rola i przykłady

Najpopularniejszym sposobem opisu wymagań funkcjonalnych są przypadki użycia (ang.use cases). Można je określić jako listy kroków (składających się na scenariusz) kolejnych interakcji użytkownika z systemem w celu realizacji danego wymagania. Jest to forma przyjazna zarówno dla klienta (gdyż nie wymaga technicznej wiedzy), analityka (jest prosta w
użyciu) oraz programisty (wiadomo dokładnie jak należy zaimplementować wymaganie), ale także testera (który na tej podstawie może łatwiej ułożyć scenariusze testowe).
Przypadki użycia składają się zwykle z paru elementów:

- Identyfikator – z uwagi na często dużą liczbę wymagań w dokumentacji, łatwiej jest je znajdować poprzez alfanumeryczne identyfikatory aniżeli nazwy.
- Nazwa – powinna dobrze opisywać wymaganie, konkretnie je podsumowywać (np. "dodawanie oceny", a nie "zarządzanie oceną"). Poleca się używać formy bezosobowej.
- Aktorzy – wymaganie opisuje interakcję użytkownika (o konkretnej roli lub rolach) z systemem. System nie jest wymieniany osobno – jest "domyślnym" aktorem.
- Warunki wstępne i końcowe - określają zdarzenia lub stany, które muszą zaistnieć, aby był sens rozpatrywać całe wymaganie. W warunkach wstępnych często umieszcza się informację o konieczności zalogowania się użytkownika.
- Główny scenariusz – lista kroków opisujących kolejne kroki realizacji wymagania (a więc osiągnięcia jego "celu") przez użytkownika. Obejmuje ona tzw. happy day scenario – pozytywny przebieg wydarzeń, najbardziej typowy, nieprzerwany od początku do końca.
- Rozszerzenia – w przypadku, kiedy mogą wystąpić pewne sytuacje wyjątkowe, należy je umieścić w rozszerzeniach. Z uwagi na przejrzystość, poleca się umieszczać je po głównym scenariuszu, z numeracją adekwatną do konkretnych kroków z typowego przebiegu.

Przypadki użycia mogą być jednego z trzech poziomów:

- Poziom biznesowy – opisuje procesy biznesowe i w ogólny sposób precyzuje przepływ informacji w systemie. Pokazuje interakcję pomiędzy różnymi rolami, oddziałami firmy i abstrahuje od poszczególnych funkcji systemu. Scenariusz często obejmuje wiele osób i niekoniecznie musi zamykać się w jednej sesji (może to być kilka sesji, łącznie trwających przez dłuższy okres czasu).
- Poziom użytkownika – najbardziej typowy, opisuje konkretne wymaganie funkcjonalne. Zwykle dotyczy interakcji jednego użytkownika (o konkretnej roli) z systemem informatycznym, jak np. edytowanie protokołu. Ważne jest, aby w tym
  poziomie nie wnikać w techniczne szczegóły dotyczące np. interfejsu użytkownika, pomijamy także opis szczegółowych danych przy wypełnianiu wszelkiego rodzaju formularzy (chyba że są one krytyczne dla wymagania – przykładowo możemy
  wspomnieć o konieczności nadania przez użytkownika nazwy przedmiotu, ale nie opisujemy jego konkretnych cech jak liczba punktów ECTS, liczba godzin itp.). Ten poziom obejmuje jedną sesję, mieszczącą się w kilku lub kilkunastu minutach.
- Poziom podfunkcji – dotyczy szczegółów technicznych wymagania, architektury i graficznego interfejsu użytkownika. Ten poziom może być wykorzystywany przy niektórych wymaganiach, aby można było je lepiej zrozumieć.

## 23. Testowanie oprogramowania - testy jednostkowe, systemowe, integracyjne, użyteczności

**Test jednostkowy** – metoda testowania tworzonego oprogramowania poprzez wykonywanie testów weryfikujących poprawność działania pojedynczych elementów (jednostek) programu – np. metod lub obiektów w programowaniu obiektowym lub procedur w programowaniu proceduralnym. Testowany fragment programu poddawany jest testowi, który wykonuje go i porównuje wynik (np. zwrócone wartości, stan obiektu, zgłoszone wyjątki) z oczekiwanymi wynikami – tak pozytywnymi, jak i negatywnymi (niepowodzenie działania kodu w określonych sytuacjach również może podlegać testowaniu). Ich głównym celem jest znalezienie błędów w implementacji danej jednostki / komponentu.

**Testy integracyjne** - sprawdzają czy komponenty poprawnie współdziałają ze sobą. Przykładem może być współpraca między aplikacją webową a bazą danych, ale nie tylko – przykładem może być współpraca pomiędzy dwiema klasami. Przeprowadzane są niekiedy również testy interfejsów API (nastawione głównie na wykrycie błędów), czy też testy między aplikacją a sprzętem. Można stwierdzić, że testy integracyjne mają na celu wykrycie błędów podczas interakcji pomiędzy systemami lub jego częściami.

**Testy systemowe** przeprowadzamy, gdy elementy systemu zostały ze sobą zintegrowane. Jest to ten moment, w którym sprawdzamy funkcjonalność systemu. Na tym etapie możemy przeprowadzać testy e2e (end to end). Testy e2e są to testy przeprowadzane z punktu widzenia użytkownika, obejmują całe scenariusze testowe np. zaczynając od założenia konta, obejmujące zalogowanie się do systemu oraz wykonanie operacji by na końcu się wylogować. Dzięki tym testom jesteśmy w stanie się dowiedzieć na ile nasz stworzony system spełnia pierwotne założenia.

**Testy akceptacyjne** zazwyczaj są wykonywane po stronie klienta. Do tego rodzaju testów – testowany obszar aplikacji musi w pełni działać. Głównym celem testów akceptacyjnych nie jest znajdowanie błędów, a upewnienie się że aplikacja spełnia oczekiwania klienta i użytkowników. Pozwalają ocenić gotowość systemu do wdrożenia. Testy akceptacyjne odbywają się najczęściej w symulowanym środowisku produkcyjnym.

**Testy użyteczności** to technika wykorzystywana w projektowaniu zorientowanym na użytkownika, w celu oceny produktu poprzez testowanie go na przyszłych użytkownikach. Dają one bezpośrednią informację na temat tego, w jaki sposób użytkownicy korzystają z systemu, czy poprawnie rozumieją zaimplementowane funkcjonalności. Pozwalają sprawdzić czy użytkownicy potrafią korzystać z wszystkich dostępnych funkcjonalności.

## 24. Diagramy UML – stanów, aktywności, interakcji, klas

**Diagram klas** - jest to diagram, który ma za zadanie zobrazować system w sposób statyczny. Ilustruje struktury klas i zależności między nimi. Pokazuje określony fragment systemu. Każda klasa na diagramie zawiera informacje o swoich atrybutach, metodach oraz powiązaniach z innymi klasami. Diagram ten jest elementem wejściowym, na którym bazują inne diagramy w UML.

**Diagramy interakcji** - ułatwiają zrozumienie zależności w przepływie sterowania. Stanowią często precyzyjny opis pojedynczego przypadku użycia. Bazują na istniejącym diagramie klas i opisują one sposób w jaki obiekty współpracują ze sobą w celu zrealizowania konkretnej funkcji systemu (przypadku użycia lub scenariusza danego przypadku użycia). Pozwalają na lepsze zrozumienie zdarzeń zachodzących pomiędzy nimi. Ponadto mogą służyć jako model do generowania gotowego kodu programu przez niektóre narzędzia typu CASE(Computer-Aided Software Engineering). Na takim diagramie przedstawia się zazwyczaj zachowanie systemu dotyczące jednego przypadku użycia.

**Diagram stanów** - jest to diagram, który pozwala na kompletne i jednoznaczne określenie stanów obiektu oraz zdarzeń powodujących zmiany (przejścia między stanami). Można z takiego diagramu odczytać również, jakie sekwencje sygnałów powodują przejście systemu w dany stan. 

**Diagram aktywności** - znany również jako diagram aktywności, jest pewną mutacją diagramu stanów, z tą różnicą, że diagram aktywności skupia się raczej na opisaniu jakiegoś procesu, w którym uczestniczy wiele obiektów, zaś diagram stanów pokazuje, jakie są możliwe stany konkretnego obiektu. Diagram aktywności jest bardzo dobrym narzędziem, gdy chcemy przedstawić odpowiedzialność obiektów w ramach jakiegoś procesu.

## 25. Paradygmat programowania obiektowego – założenia (Abstrakcja, Hermetyzacja, Polimorfizm, Dziedziczenie), pojęcia klasy i obiektu

**Abstrakcja** - Każdy obiekt w systemie służy jako model abstrakcyjnego "wykonawcy", który może wykonywać pracę, opisywać i zmieniać swój stan, oraz komunikować się z innymi obiektami w systemie, bez ujawniania, w jaki sposób zaimplementowano dane cechy. Jest to uproszczenie rozpatrywanego problemu, polegające na skupieniu się na cechach kluczowych dla algorytmu, czy też elementach wspólnych dla grupy klas, nie na dokładnej implementacji. 

**Hermetyzacja** - zapewnia, że obiekt nie może zmieniać stanu innych obiektów w nieokreślony sposób. Polega na tym, że klasa ukrywa swoje dane składowe i metody, udostępniając interfejs określający w jaki sposób pozostałe klasy mogą uzyskać dostęp do tych danych. Jedynie za pomocą określonych metod mamy możliwość zmienić stan obiektu, bezpośredni dostęp do zmiennych jest zabroniony. 

**Dziedziczenie** - umożliwia stworzenie hierarchii obiektów w programie. Polega na przejęciu właściwości i funkcjonalności obiektów innej klasy i ewentualnej modyfikacji tych właściwości i funkcjonalności w taki sposób, by były one bardziej wyspecjalizowane.

**Polimorfizm** - referencje i wskaźniki obiektów mogą dotyczyć obiektów różnego typu, a wywołanie metody dla referencji spowoduje zachowanie odpowiednie dla pełnego typu obiektu wywoływanego. Innymi słowy polimorfizm umożliwia rozdzielenie kodu od konkretnych typów. Zazwyczaj można wyróżnić dwa rodzaje polimorfizmu: dynamiczne - wykonywane podczas działania programu (np. metody wirtualne), a także statyczne - na etapie kompilacji (np. przeciążenia operatorów).

**Klasa** - jest to typ danych definiowany przez programistę. Każda klasa jest tworem zawierającym struktury danych, a także metody określające jakie czynności można wykonać na tych danych. Pojedyncza klasa powinna jasno reprezentować określone pojęcie, dla którego jeszcze nie istnieje odpowiedni typ. Klasa jest szablonem do tworzenia obiektów.

**Obiekt** - jest to instancja klasy. Klasa jest tylko szablonem, natomiast obiekt jest elementem stworzonym na jej podstawie. Każdy obiekt ma swoją tożsamość, pozwalającą na odróżnienie od innych obiektów oraz stan, przez który rozumie się aktualny stan danych składowych tego obiektu, modyfikowane w trakcie działania programu.

## 26. Algorytmy grupowania i klasyfikacji - zastosowanie i przykłady

Algorytmy grupowania to algotytmy z dziedziny uczenia maszynowego, które mają za zadanie zgrupowanie elementów danego zbioru. Elementy w jednej grupie powinny mieć podobne właściwości, a pozostałe elementy powinny być wyraźnie inne.

Algorytmy grupujące mogą dać wartościowe informacje o zbiorach danych, są one przydatne przy rozpoznawaniu powtarzających się wzorów.

Najpopularniejsze algorytmy grupujące to:

KNN (K Nearest Neighbours) - algorytm ten używa odległości punktów danych aby zbierać je w grupy. Liczba K oznacza ilość najbliszych punktów branych pod uwagę przy rozstrzyganiu klasy. Jeśli K najbliższych punktów nie określa jednoznacznie klasy, wówczas przeważa ta klasa, której reprezentatntów jest najwięcej pośród K punktow. Algorytm ten przydatny jest na przykład przy kategoryzowaniu konsumentów analizowanego produktu.

Naive Bayes - Ten algorytm bazuje na modelu, który mówi o tym jakie jest prawdopodobieńswo wystąpienia konkretnej cechy w kazdej z klas. Według tego modelu liczy prawdopodobieństwo tego, ze badany element należy do wybranych klas jesli posiada dane cechy. W ten sposób otrzymujemy wynik dla kazdej klasy i wybieramy klasę, której wynik jest najwyższy. Dobrym przypadkiem uzycia jest stworzenie modelu rozpoznajacego spam na podstawie wystapienia danych słów w wiadomości.

Drzewo decyzyjne - Jest to algorytm, który polega na podjęciu szeregu decyzji opartych na parametrach kazda decyzja przenosi na nizszy poziom w strukturze drzewa a ostatni poziom(liście drzewa) to wynik, czyli klasa do której należy dany element. Algorytm ten dobrze nadaje się do klasyfikacji danych wielowymiarowych.
## 27. Stało i zmiennopozycyjna reprezentacja liczb
**Reprezentacja stałopozycyjna** charakteryzuje się stałym położeniem kropki dziesiętnej. Na część całkowitą liczby oraz na część ułamkową przeznaczona jest stała, z góry określona liczba bitów.Jeśli na część ułamkową przeznaczone jest 0 bitów to reprezentacja stałopozycyjna służy do przechowywania liczb całkowitych. Jeśli liczba, którą chcemy przedstawić w tej reprezentacji, mieści się na ustalonej liczbie bitów, to może być reprezentowana dokładnie.

**Reprezentacja zmiennopozycyjna**: Liczba zmiennoprzecinkowa to reprezentacja liczby rzeczywistej zapisanej za pomocą notacji naukowej.

Wartość liczby zmiennoprzecinkowej jest obliczana według wzoru:

x = S * M * B<sup>E</sup>
gdzie:
S - znak
M - mantysa
B - podstawa systemu liczbowego
E - wykładnik

Mantysa jest znormalizowana, tj. należy do przedziału [1,B) (przedział prawostronnie otwarty!). Jeżeli M jest stałe, a E zmienia się, wówczas przesunięciu ulega przecinek – stąd właśnie pochodzi nazwa tej reprezentacji.

## 28. Podstawowe algorytmy sortowania

Dane o złożoności wzięte z anglojęzycznej wikipedii, polskojęzyczna zapewnia mniej dokładne złożoności które zgadzają się z "średnią" złożonością z wyjątkiem sortowania przez wstawianie, tam ilośc zamian równa jest O(1) zamiast O(n^2)

#### Sortowanie przez wstawianie

W algorytmie sortowania przez wstawianie ciąg danych jest dzielony na dwie części:

- już uporządkowaną (przed uruchomieniem procedury nie zawiera ona żadnych elementów)
- jeszcze nie uporządkowaną (na początku zawiera wszystkie elementy).

##### Sposób działania algorytmu:

- weź pierwszy element z części nieuporządkowanej
- wstaw go w odpowiednie miejsce w części uporządkowanej

##### Złożoność

- worst-case O(n^2) porównań i zamian
- best-case O(n) porównań O(1) zamian
- average O(n^2)

#### Sortowanie przez scalanie

W algorytmie sortowania przez scalanie jest wykorzystywana strategia "dziel i zwyciężaj"

Ideą działania algorytmu jest dzielenie zbioru danych na mniejsze zbiory, aż do uzyskania n zbiorów jednoelementowych, które same z siebie są posortowane

Algorytm ten w każdym przypadku osiąga złożoność T(n) = n\*log(n). Niestety algorytm MergeSort posiada większą złożoność pamięciową, potrzebuje do swojego działania dodatkowej, pomocniczej struktury danych.

##### Złożoność

- worst-case O(n*log(n)) 
- best-case O(n*log(n))
- average O(n*log(n))

#### Quick Sort

Zasada jego działania opiera się o metodę dziel i zwyciężaj. Zbiór danych zostaje podzielony na dwa podzbiory i każdy z nich jest sortowany niezależnie od drugiego.

Optymistyczna złożoność obliczeniowa sortowania szybkiego wynosi O(n log n) i jest to jeden z najszybszych algorytmów sortujących (a na pewno najbardziej znany). Doskonale radzi sobie z sortowaniem wielkich tablic i został włączony do standardowej biblioteki języka C.

##### Złożoność

- worst-case O(n^2) 
- best-case O(n*log(n))
- average O(n*log(n))

#### Bubble Sort

Algorytm sortowania bąbelkowego polega na porównywaniu par elementów leżących obok siebie i, jeśli jest to potrzebne, zmienianiu ich kolejności.
Każdy element jest tak długo przesuwany w ciągu, aż napotkany zostanie element większy od niego, wtedy w następnych krokach przesuwany jest ten większy element

##### Złożoność

- worst-case O(n^2) porównań i O(n^2) zamian
- best-case O(n) porównań O(1) zamian
- average O(n^2) porównań i O(n^2) zamian

## 29. Pojęcie stosu i kolejki

#### Stos

Stos (ang. Stack) – liniowa struktura danych, w której dane dokładane są na wierzch stosu i z wierzchołka stosu są pobierane. W danym momencie tylko jeden z elementów przechowywanych na stosie jest dostępny – ostatni dodany. Z tego względu mówi się, że stos jest strukturą typu LIFO (Last In First Out).
Podstawowymi operacjami na strosie są push - odłożenie obiektu na stos; pop - ściągnięcie obiektu ze stosu i zwrócenie jego wartości; isEmpty - sprawdzenie czy na stosie znajdują się jakieś obiekty.
Stos jest używany w systemach komputerowych na wszystkich poziomach funkcjonowania systemów informatycznych. Stosowany jest przez procesory do chwilowego zapamiętywania rejestrów procesora, do przechowywania zmiennych lokalnych, a także w programowaniu wysokopoziomowym.

Jedną z implementacji stosu jako struktury danych jest obszar w pamięci wydzielony dla danego wątku, służący do przechowywania adresów powrotu i zmiennych lokalnych.

#### Kolejka

Kolejka (ang. queue) – liniowa struktura danych, w której nowe dane dopisywane są na końcu kolejki, a z początku kolejki pobierane są dane do dalszego przetwarzania Pierwszy element, który „stanął” w kolejce, jest pierwszym, który z niej wyjdzie. Natomiast każdy nowy element musi stanąć na jej końcu. Kolejka jest więc nazywana strukturą typu FIFO(First In First Out).
Podstawowymi oepracjami kolejki są: enqueue - dodanie obiektu na ostatnie miejsce kolejki; dequeue - ściągnięcie pierwszego dostępnego obiektu w kolejce.

Specjalną modyfikacją kolejki jest kolejka priorytetowa – każda ze znajdujących się w niej danych dodatkowo ma przypisany priorytet (klucz), który służy do określenia kolejności poszczególnych elementów w zbiorze. Oznacza to, że pierwsze na wyjściu niekoniecznie pojawią się te dane, które w kolejce oczekują najdłużej, lecz te o największym (lub najmniejszym) priorytecie.

Kolejkę spotyka się przede wszystkim w sytuacjach związanych z różnego rodzaju obsługą zdarzeń. W szczególności w systemach operacyjnych ma zastosowanie kolejka priorytetowa, przydzielająca zasoby sprzętowe uruchomionym procesom.

## 30. Przekazywanie parametrów do funkcji poprzez wartość, zmienną i referencję.

Parametry funkcji inaczej zwane argumentami funkcji mogą być przekazywane do na dwa sposoby: **przez wartość lub przez referencję.**

#### Przekazywanie argumentów funkcji przez wartość.

W momencie wywołania funkcji tworzona jest na jej potrzeby zmienna lokalna o podanej nazwie i do niej jest kopiowana
wartość przekazana do funkcji. Po zakończeniu działania funkcji wszystkie zmienne powiązane z parametrami przekazywanymi do funkcji przestają istnieć. Po wyjściu z funkcji znów odwołujemy się do oryginalnej zmiennej, która nie została zmodyfikowana.

### Przekazywanie argumentów funkcji przez zmienną (zakłam że chodzi tu o przekazanie jej przez wskaźnik)

W przypadku przekazywania parametrów do funkcji przy użyciu wskaźnika, przekazujemy je takie przez wartość. Wynika to z faktu że wskaźnik też jest typem zmiennej (zmienna wskaźnikowa), jednak mimo że wskaźnik (adres miejsca w pamięci) zostanie skopiowany  to wartość wyłuskana ze wskaźnika nie jest już kopią. W języku C++ wskaźniki zaznaczane są w kodzie przy użyciu * co informuje kompilator że zmienna jest wskaźnikiem.

Wskaźnik jest typem zmiennej, czyli zmienną wskaźnikową. Do wskaźnika możemy przypisać dowolny adres pamięci, na którą ten wskaźnik będzie wskazywał. Dlatego przekazując wskaźnik do funkcji, zostaje on przekazany przez wartość (a więc skopiowany), jednak prawdziwą wartością wskaźnika jest właśnie adres pamięci. Próbując wyświetlić wskaźnik ukaże się naszym oczom adres pamięci. Aby natomiast dostać się do prawdziwej wartości wskaźnika, trzeba posłużyć się operatorem wyłuskania (gwiazdka), czyli operatorem pobrania wartości wskaźnika.

#### Przekazywanie argumentów do funkcji przez referencje.

Referencja jest bezpośrednim adresem pamięci danej zmiennej.W momencie wywołania wszelkie operacje są wykonywanie na oryginalnych zmiennych, poprzez przekazanie do funkcji referencji do oryginalnej wartości. Po zakończeniu działania funkcji odwołujemy się do zmiennej zmodyfikowanej. Aby zaznaczyć, że chodzi o referencje przed nazwą zmiennej wpisujemy znak &

## 31. Funkcje haszujące – definicja, przykłady i zastosowania

### Definicja

Hashowanie - to proces generowania danych wyjściowych o stałym rozmiarze z danych wejściowych o zmiennym rozmiarze. Idąc dalej, cały proces jest możliwy dzięki zastosowaniu specjalnych wzorów matematycznych znanych pod nazwą algorytmów haszujących lub fukcji mieszających.

### Działanie

Każda z istniejących funkcji skrótu na podstawie tych samych danych wejściowych generuje dane wyjściowe o innym od innych funkcji skrótu rozmiarów. To, co jednak łączy wszystkie algorytmy haszujące, to fakt iż, dana funkcja mieszająca na podstawie tego samego zestawu danych zawsze wygeneruje dane wyjściowe o tym samym rozmiarze. Dla przykładu algorytm hashujący SHA-256 po przepuszczeniu przez niego jakichkolwiek danych (czyt. danych wejściowych) wyprodukuje skrót o długości 256 bitów, podczas gdy inny algorytm, SHA-1 zawsze wygeneruje skrót o długości 160 bitów.

### Zastosowanie

Konwencjonalne funkcje skrótu mają szeroki zakres zastosowań, wliczając w to chociażby znakowanie plików w bazach danych do ich prostszego (i szybszego) wyszukiwania, analizę dużych plików czy generalnie zarządzanie danymi. Z drugiej strony, kryptograficzne funkcje skrótu są również szeroko stosowane w aplikacjach związanych z bezpieczeństwem informacji w takich dziedzinach jak np. uwierzytelnianie wiadomości przesyłanych w formie cyfrowej czy cyfrowa tożsamość. Jeśli chodzi o Bitcoina, to algorytmy haszujące są istotną częścią procesu kopania (ang. miningu), a poza tym odgrywają dużą rolę w generowaniu nowych adresów i kluczy.

### Przykłady

https://edu.pjwstk.edu.pl/wyklady/bdk/scb/main66.html

## 32. Złożoność obliczeniowa algorytmu

**Złożoność obliczeniowa algorytmu** – ilość zasobów komputerowych potrzebnych do jego wykonania:

- **Złożoność czasowa** - to ilość czasu potrzebnego do wykonania zadania, wyrażona jako funkcja ilości danych.
- **Złożoność pamięciowa** - to ilość pamięci potrzebnej do wykonania zadania, wyrażona jako funkcja ilości danych.

- **złożoność pesymistyczna O()** - ilość zasobów potrzebnych do wykonania algorytmu przy założeniu najbardziej "złośliwych/najgorszych" danych,
- **złożoność oczekiwana Θ()** - ilość zasobów potrzebnych do wykonania algorytmu przy założeniu "typowych" (statystycznie oczekiwanych) danych wejściowych,
- **złożoność optymistyczna** - ilość zasobów potrzebnych do wykonania algorytmu przy założeniu "najlepszych" danych.

#### Rozróżniamy następujące złożoności obliczeniowe:

- **stała - Θ(1)** - gdy czas wykonania algorytmu jest stały i niezależny od rozmiaru danych wejściowych
- **logarytmiczna - Θ(log n)** - kiedy czas ten rośnie logarytmiczne wraz ze wzrostem wielkości danych. Logarytm jest niemal zawsze o podstawie 2 (w przypadku notacji asymptotycznych nie ma to aczkolwiek znaczenia, bowiem podstawa logarytmu może być zmieniona poprzez pomnożenie przez czynnik stały,
- **liniowa - Θ(n)** - czas działania jest proporcjonalny do rozmiaru danych wejściowych,
- **liniowo-logarytmiczna - Θ(n log n)** - złożoność jest iloczynem funkcji liniowej i logarytmicznej,
- **kwadratowa - Θ(n2)** - liczba instrukcji algorytmu rośnie proporcjonalnie do kwadratu rozmiaru danych wejściowych,
- **sześcienna - Θ(n3)** - liczba instrukcji algorytmu rośnie proporcjonalnie do sześcianu rozmiaru danych wejściowych,
- **wielomianowa - Θ(nr + nr-1 + ... + n1)** - liczba instrukcji algorytmu rośnie proporcjonalnie do pewnego wielomianu rozmiaru danych wejściowych,
- **wykładnicza - Θ(2n)** - czas wykonania rośnie wykładniczo względem rozmiaru danych,
- **silni - Θ(n!)** - czas wykonania rośnie z szybkością silni względem rozmiaru danych

http://home.agh.edu.pl/~horzyk/lectures/pi/ahdydpiwykl8.html#zlozonoblicz

## 33. Klasy złożóności P, NP

W praktyce dzielimy algorytmy wg ich złożoności na 2 klasy

P - biór problemów decyzyjnych, które można rozwiązać na maszynie Turinga w czasie wielomianowym

NP - biór problemów decyzyjnych, które można rozwiązać na niedeterministycznej maszynie Turinga w czasie wielomianowym. Niedeterministyczny algorytm to taki, który zawiera instrukcję: choice. Działa ona w sposób losowy, a mianowicie zwraca losowo 0 bądź 1. Tak więc można powiedzieć, że instrukcja choice odgaduje rozwiązanie. Algorytm przerywa działanie, jeżeli odgadnięte rozwiązanie będzie prawidłowe i zwraca wartość success. Przykładem problemu klasy NP jest pytanie „czy dana liczba jest złożona”. Algorytm niedeterministyczny dla tego problemu odgaduje kolejne bity dzielnika danej liczby. Kolejnym krokiem jest sprawdzenie czy otrzymany w sposób niedeterministyczny dzielnik faktycznie dzieli daną liczbę.

## 34. Reprezentacja liczb w pozycyjnym systemie liczbowym. System dwójkowy i szesnastkowy

**Dwójkowy system liczbowy** - pozycyjny system liczbowy, w którym podstawą jest liczba 2, a do zapisu liczb potrzebne są tylko dwie cyfry: 0 i 1.
Używany w matematyce, informatyce i elektronice cyfrowej, gdzie minimalizacja liczby stanów (do dwóch) pozwala na prostą implementację sprzętową odpowiadającą zazwyczaj stanom wyłączony i włączony oraz zminimalizowanie przekłamań danych.

**Szesnastkowy system liczbowy** - pozycyjny system liczbowy, w którym podstawą jest liczba 16. Do zapisu liczb w tym systemie potrzebne jest szesnaście znaków (cyfry 0-9 oraz litery A-F)
Szesnastkowy system liczbowy stosuje się w informatyce, w przypadku programowania niskopoziomowego, sterowania sprzętem komputerowym, wyboru adresów itp. np. adresy IPv6 podawane są w pozycyjnym systemie szesnastkowym.

## 35. Szybka implementacja słownika (jakaś prosta metoda)

Słownik jest abstrakcyjną strukturą danych służącą dooperowania na parach klucz-wartość o następującym zbiorze operacji:

- search (K key) - zwraca wartość związaną z kluczem key
- insert (K key, V value) - umieszcza nową parę klucz - wartość w słowniku
- delete (K key) - usuwa parę związaną z kluczem key

#### Przykłady:

- baza kontaktów(np. klucz: osoba, wartość: numer telefonu lub odwrotnie)
- słownik języka obcego: klucz: wyraz w języku bazowym, wartość: znaczenie w innym języku

#### Prosta implementacja słownika

Dwie tablice: keys i values. Tablica keys trzyma klucze a “równoległa” tablica values pod odpowiadającymi indeksami trzyma wartości. Klucze mogą być posortowane albo nie.

#### Bardziej skomplikowana implementacja słownika

Drzewo BST (Binary Search Tree) - każdy węzeł jest obiektem klasy posiadającym pola:

- key (przechowuje klucz)
- value (przechowuje wartość)
- parent (wskaźnik do rodzica)
- left (wskaźnik na lewego syna)
- right (wskaźnik na prawego syna)

http://users.pja.edu.pl/~msyd/wyka-pl/dictionary9-pl.pdf

## 36. Sieci komputerowe: czym się różni prot. TCP od UDP + ich zastosowania.

TCP i UDP są protokołami używanymi do wysyłania bitów danych - znanych jako pakiety. Oba protokoły opierają się na protokole IP.

- **TCP** (Transmission Control Protocol) jest połączeniowym, niezawodnym i strumieniowym protokołem komunikacyjnym stosowanym do przesyłania danych między procesami uruchomionymi na różnych maszynach. TCP jest protokołem działającym w trybie klient–serwer. Serwer oczekuje na nawiązanie połączenia na określonym porcie. Klient inicjuje połączenie do serwera. Gdy maszyna A wysyła dane do maszyny B, maszyna B jest powiadamiana o nadejściu danych, a następnie przesyła potwierdzenie odbioru. W przeciwieństwie do UDP, TCP gwarantuje wyższym warstwom komunikacyjnym dostarczenie wszystkich pakietów w całości, z zachowaniem kolejności i bez duplikatów. Zapewnia to wiarygodne połączenie kosztem większego narzutu w postaci nagłówka i większej liczby przesyłanych pakietów.
Aplikacje, w których zalety protokołu sterowania transmisją przeważają nad wadami (większy koszt związany z utrzymaniem sesji TCP przez stos sieciowy), to między innymi programy używające protokołów warstwy aplikacji: HTTP, SSH, FTP czy SMTP/POP3 i IMAP4.

- **UDP** (User Datagram Protocol) jest protokołem bezpołączeniowym, więc nie ma narzutu na nawiązywanie połączenia i śledzenie sesji. Korzyścią płynącą z takiego uproszczenia budowy jest szybsza transmisja danych i brak dodatkowych zadań, którymi musi zajmować się host posługujący się tym protokołem. Mówiąc najprościej, gdy maszyna A wysyła pakiety do komputera B, strumień jest niekierunkowy. Oznacza to, że transmisja danych odbywa się bez ostrzeżenia odbiorcy (maszyna B), a odbiorca otrzymuje dane bez konieczności potwierdzania (maszyna A). Z tych względów UDP jest często używany w takich zastosowaniach jak wideokonferencje, strumienie dźwięku w Internecie i gry sieciowe, gdzie dane muszą być przesyłane możliwie szybko, a poprawianiem błędów zajmują się inne warstwy modelu OSI. Przykładem może być VoIP lub protokół DNS.

http://home.agh.edu.pl/~opal/sieci/wyklady/7-tcp_udp.pdf

## 37. Języki programowania: różnica między C++ a Javą jeśli chodzi o wykonywanie programów. Uzasadnić rozwiązanie stosowane w Javie.

- Java kompilowana jest do kodu bajtowego, zaź C++ odrazu do kodu maszynowego.
- Kod C++ wymaga nie tylko kompilacji ale też łączenia (linking), proces ten odnosi się do tworzenia pojedynczego pliku wykonywalnego z wielu plików obiektowych.
- Java wykonuje pewne późne wiązania, czyli wywołania funkcji, a rzeczywisty kod jest wykonywany w czasie wykonywania. Tak więc mała zmiana w jednym obszarze nie musi powodować kompilacji całego programu. W C ++ to skojarzenie musi być wykonane w czasie kompilacji. Nazywa się to wczesnym wiązaniem.
- Kompilatory C ++ muszą dokonywać optymalizacji, ponieważ nie ma innej rzeczy, która by to zrobiła. Kompilator Java wykonuje w zasadzie prostą translację 1: 1 kodu źródłowego Javy na kod bajtowy języka Java, na tym etapie nie są wykonywane żadne optymalizacje (pozostaje to do wykonania przez JVM).
- C++ wykonywany jest natywnie, a Java na wirtualnych maszynach.

https://stackoverflow.com/questions/2095277/difference-between-c-and-java-compilation-process
https://www.guru99.com/cpp-vs-java.html
