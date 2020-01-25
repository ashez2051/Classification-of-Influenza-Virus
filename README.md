# Classification-of-Influenza-Virus

Background
The seasonal influenza is typically a type A influenza virus, which is further categorized into different serotypes. Every season is typically dominated by one flu serotype, and it is necessary to know this in order to produce the annual vaccines. The serotype is decided by two of the protein-coding genes in the virus, named hemagglutinin and neuraminidase. The first serotype was the infamous Spanish flu that killed a lot of people around 100 years ago. This has serotype H1N1, where H and N is short for hemagglutinin and neuraminidase, respectively. Later serotypes have been named by increasing the numbers when new variants of these two genes have been observed, i.e. H2N3 etc. Viruses of the same serotype are similar but not identical, i.e. there is always some (smallish) variation in these genes even within the same serotype. When the DNA sequence of a new virus is found we want to have a method implemented that can tell us, with best possible accuracy, which serotype this is.

In this project we will see how well we can classify such viruses using L-mer counting and a simple KNN classifier. We will focus on the neuraminidase, but as soon as the code is made, it is easy to also apply it to the hemagglutinin.

Part 1
Download Neuraminidase.fasta, which contains DNA sequences in FASTA-format. This format means each DNA sequence is stored as

A header line, starting with ">". This is a descriptive text for each sequence, and is always a single line.
A DNA sequence consisting of A, C, G and T. This is often split into several lines, but should be stored as one text in the table.
Multiple sequences are found below each other, i.e. we have first a header, then a sequence, then the next header, its corresponding sequence, and so on.
Read the file into R, and store it as a table. The table should have two text columns, one for the header lines (Header) and one for the sequences (Sequence). HINT: In week 2 we made some code you may use here. There are also several R packages with functions for reading such files, but most of them will not organize the data into a table, or even output text.

Somewhere inside most header lines you find information about the serotype for the corresponding sequence. It is always a text of the format HxNy where x and y are integers. You can safely assume x and y are integers with 1 or 2 digits. The H-type is the first part (Hx) and the N-type is the second part (Ny), and the full serotype contains both parts.

Make a script that uses the Header column from above and adds columns Serotype, H.type and N.type to the table, containing the corresponding texts extracted from the Header column texts. Then, remove all cases where the serotype is missing.

Make a plot showing how frequent each N-type occurs in the data set. We also wonder if certain H-types are associated with N-types. For a given H-type, does it combine equally often with all or only some very specific N-types? Try to come up with some graphical display that illustrates if this is the case.

Part 2
A popular way of modelling DNA sequence data is to count L-mers. An L-mer is simply a word of length L. As an example, we have the sequence AATCTGCT and split it into words of length L=3 giving us the words AAT, ATC, TCT, CTG, TGC and GCT. Notice that the L-mers (3-mers) overlap, i.e. the first is the substring from 1 to 3, the next is from 2 to 4, then 3 to 5, etc. After splitting the sequence into L-mers, we simply count how often we see every possible L-mer. This is a way of transforming a sequence into a vector of numbers.

Make a function that takes as input a single DNA sequence and an integer value L, and returns the vector of L-mer counts. The DNA alphabet is A, C, G and T. This means if L=1 the function returns a vector of 41=4 counts, if L=2 the vector has 42=16 counts, etc. NOTE: It is important that a count is returned for all possible L-mers of the given length, which means the count 0 may occur if some L-mer is not found in some particular sequence. It is also important that the order of the L-mers is always the same, and we require the L-mers to be in alphabetical order.

Next, make a script that uses L=2 and the function you made above to create a matrix with one row for each sequence in the data from part 1. Also, divide all elements in a row of this matrix by its row-sum. All rows in the matrix should then sum to 1. This makes the values independent of sequence length. Use the actual L-mers as column-names (AA, AC,…etc) of this matrix. Finally, convert this matrix to a table, and bind it to the table from part 1.

From the full data set, extract the subset containing only the cases for N-types N1, N3 and N6. Fit an LDA-model to these data, using the N-types as response (class-labels). Make a plot of the cases as points in the space of linear discriminants (we did this in week 2-3). Map colors to the N-types.


Part 3
Make a K-nearest-neighbor (KNN) classifier function for L-mer data. The basic step in any KNN method is the computation of distances between data cases, i.e. rows of the matrix of L-mers from part 2. We will use distances according to this formula:
d(p,q)=∑i=1M|log2(pi/qi)|

Make a function that computes such distances. It should take as input a vector p (corresponding to a single row from the L-mer matrix) and a matrix Q (many rows from the L-mer matrix), and then compute the distance from p to all the rows in Q. It should then return the vector of distances, one for each row in Q.

Next, make the KNN function itself. This should take as input the matrix of training data as well as the corresponding class-label for each training data case. It must also take a matrix of data to be classified (test data) and a value K (the number of neighbors). This function then uses the distance-function from above, and classifies the test sequences. It returns a vector of class-labels, one for each test data object.

Use this function to classify the N-types from the neuraminidase data from previous parts. Estimate the classification accuracy when K is 1, 3 and 5, using a 100-fold cross-validation. Find some way to visualize the results.
