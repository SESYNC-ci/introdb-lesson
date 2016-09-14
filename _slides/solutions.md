---
---

## Exercise Solutions

<!--split-->

## Solution 1


~~~r
dbGetQuery(con, "select species_id, taxa, genus
                 from species")
~~~
{:.text-document title="lesson-3.R"}
~~~
   species_id    taxa            genus
1          AB    Bird       Amphispiza
2          AH  Rodent Ammospermophilus
3          AS    Bird       Ammodramus
4          BA  Rodent          Baiomys
5          CB    Bird  Campylorhynchus
6          CM    Bird      Calamospiza
7          CQ    Bird       Callipepla
8          CS Reptile         Crotalus
9          CT Reptile    Cnemidophorus
10         CU Reptile    Cnemidophorus
11         CV Reptile         Crotalus
12         DM  Rodent        Dipodomys
13         DO  Rodent        Dipodomys
14         DS  Rodent        Dipodomys
15         DX  Rodent        Dipodomys
16         EO Reptile          Eumeces
17         GS Reptile         Gambelia
18         NL  Rodent          Neotoma
19         NX  Rodent          Neotoma
20         OL  Rodent        Onychomys
21         OT  Rodent        Onychomys
22         OX  Rodent        Onychomys
23         PB  Rodent      Chaetodipus
24         PC    Bird           Pipilo
25         PE  Rodent       Peromyscus
26         PF  Rodent      Perognathus
27         PG    Bird        Pooecetes
28         PH  Rodent      Perognathus
29         PI  Rodent      Chaetodipus
30         PL  Rodent       Peromyscus
31         PM  Rodent       Peromyscus
32         PP  Rodent      Chaetodipus
33         PU    Bird           Pipilo
34         PX  Rodent      Chaetodipus
35         RF  Rodent  Reithrodontomys
36         RM  Rodent  Reithrodontomys
37         RO  Rodent  Reithrodontomys
38         RX  Rodent  Reithrodontomys
39         SA  Rabbit       Sylvilagus
40         SB    Bird         Spizella
41         SC Reptile       Sceloporus
42         SF  Rodent         Sigmodon
43         SH  Rodent         Sigmodon
44         SO  Rodent         Sigmodon
45         SS  Rodent     Spermophilus
46         ST  Rodent     Spermophilus
47         SU Reptile       Sceloporus
48         SX  Rodent         Sigmodon
49         UL Reptile           Lizard
50         UP    Bird           Pipilo
51         UR  Rodent           Rodent
52         US    Bird          Sparrow
53         ZL    Bird      Zonotrichia
54         ZM    Bird          Zenaida
~~~
{:.output}

<aside class="notes" markdown="block">
[Return](#exercise-1)
</aside>

<!--split-->

## Solution 2


~~~r
df <- dbGetQuery(con, "select weight, month, plot_type, taxa
                       from surveys
                       join plots on surveys.plot_id = plots.plot_id
                       join species on surveys.species_id = species.species_id
                       where weight is not null")
~~~
{:.text-document title="lesson-3.R"}

<aside class="notes" markdown="block">
[Return](#exercise-2)
</aside>












