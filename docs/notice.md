---
toc: true
layout: default
title: Notice
---

## Knowledge curation management

Please keep your progress frequently and save or update your files after completing a knowledge mining of a literature, which may save you from losing your current work progress.

## Share your results

- Prophet Label Studio Account configuration is completed by themselves through the invitation link, and the account and password are set by themselves;

- Through the Prophet Label Studio, the login page to confirm your project project;

- The final completion will be presented in the form of an individual and a team knowledge map.

Visit [OpenProphetDB](https://prophetdb.org) for the current ongoing projects and contact the appropriate project group members to invite them to join the appropriate Organization.

## Communication

There will be a meeting every two weeks to track the literature knowledge mining progress and discuss related issues, and you can watch it through the link below,

Meeting link: Ask the administrator for the link.

Video link of the previous conference: Ask the administrator for the link.

## Improve your labeling situation

On the annotation page, you can see the top tab to see the team members or add your annotation.

Meanwhile, please improve your annotation status as follows:

- Yes, No and Unknown in the middle of the bottom of the title of the article represent whether the article is related to your research objectives, if relevant, Yes, No, Unknown, unknown or need to be judged by the full text;

- The five stars on the right side of the title of the article are the scoring system, which scores the literature and knowledge according to the standards set by you or your team. One star is the lowest and five stars are the highest;

- Yes and No at the bottom of the article represent whether you need further knowledge, and enter your notes or ideas in the "Content" box below;

## Preliminary consideration

- Set the focus of knowledge mining according to the final results of each project. The following examples:

  1. The ME / CFS group, focusing on molecular mechanisms (such as genes, proteins and other promising drug targets);

  2. The mechanism should be included in the subcellular localization and in the cell type / tissue / organ.

- Each entity and its correspondence should appear in at least one article with a corresponding PMID;

- The required articles can be keyword retrieved through the Pubmed.

## Substance

### Color schemes

- Gene: red 2
- protein: Orange color 3
- disease: Brown color 4
- symptom: Deep purple color 5
- metabolite: Green, 6
- pathway: Dark pink 7
- anatomy: Gray 8
- microbe: Yellow: 9
- chemical: Black, and 0
- biological _process: light purple q
- cellular _component: Light pink w
- molecular _function: Brown, e
- Key Sentence: blue t

At present, there is no standard color scheme, and each label and color scheme can be modified and improved according to the requirements.

The existing labels and color matching are considered to set the principle of easy to distinguish and not easy to confuse. After the color, the characters (numbers or letters) are shortcut keys, which can be quickly selected and marked by the corresponding characters on the keyboard.

### ID identifiers

To implement an automatic annotation of the biochemical entities, consider:

- **Gene and RNA identifier**: match the most appropriate term from ENTREZ, preferentially using ENTREZ:ID.

- **Protein identifier**: convert proteins into genes through NCBI and other websites, match the most appropriate terms from ENTREZ, and preferentially use ENTREZ:ID for annotation.

- **Disease and disease state identifier**: match the most appropriate term from MONDO, preferentially with the corresponding MONDO:ID.

- **Symptom Identifier**: match the most appropriate term from SYMP, preferentially with SYMP:ID.

- **Metabolite identifier**: match the most appropriate term from the HMDB with the corresponding HMDB:ID.

- **Pathway identifier**: match the most appropriate term from KEGG or React, preferentially use the corresponding KEGG:ID, followed by React:ID.

- **Solution structure identifier**: match the most appropriate term from MESH, preferentially annotate with the corresponding MESH:ID.

- **Drug and chemical identifier**: match the most appropriate term from DrugBank, with the corresponding DrugBank:ID.

- **Cell composition / biological process / molecular mechanism identifier**: match the most appropriate term from the Gene Ontology (GO), preferentially annotated using GO:ID.

## Relation

- Be sure to choose the relationship after the standard entity;

- Select the relationship that is consistent with the content of the original article first, and try to use the description consistent with the original article or express the connection between the selected entities;

- **No specific connection is mentioned in the confirmation text, or if there is no relationship you chose in the Label Studio, then the general relationship of be `associated_with` is chosen.**

## Common questions

Q1: Proteins cannot be aligned in the Knowledge Graph Editor, such as interleukin-8 / IL-8.

A1: IL-8 is interleukin-8, a cytokine produced by a variety of cells and is a protein entity. Since proteins align to gene entities in the Knowledge Graph Editor, a search in NCBI yields that the gene ID of IL-8 is CXCL8, and searching for CXCL8 in the editor will bring up the corresponding entity and complete the editing.

Q2: Different names for the same entity, such as Post-Acute Sequelae of SARS-CoV-2 infection (PASC) or Long-haul COVID or Post-COVID-19 Syndrome or Post-Acute COVID-19 Syndrome

A2: Unified alignment is Long COVID-19 | MONDO:0100233.

Q3: Can I find entities by their IDs when aligning in the Knowledge Graph Editor?

A3: Of course you can! If you enter MONDO:0100233, the entity Long COVID-19 will be searched.

Q4: How should I mark a ratio or multiple side-by-side entities in the markup content?

A4: Mark each entity and indicate the ratio by key phrases in the alignment editor.

Q5: In which label do immune cells such as B cells, T cells, human lung cells, and cardiomyocytes count?

A5: Immune cells can be labeled as B/T cell activation under Biological Processes, and lung cells and cardiomyocytes can be labeled as Lung and Heart under Anatomical Structures.

Q6: What will it look like if I have labeled some entities on Label Studio, but don't go further to Knowledge Graph-Editor to modify the entity?

A6: Then it is not possible to import the data into and form the Knowledge Graph, so this step must be needed！

Q7: Why I have no way to use the latest version?

A7: It is recommended to clear the browser cache or use the no-trace browsing mode, Google Chrome is recommended.

Q8: Why can't I search for a certain entity?

A8: First of all, check the editor to input less than 3 letters, in order to improve the accuracy of the search, the search less than 3 letters will not be displayed; secondly, the entity is not normalized, it is recommended to use the normalized entity name; lastly, the entity does not exist in the database, please mark it as Unknown.

Q9: When 2 entities appear in the same article, they must have some kind of connection, so associate with is used in what situation?

A9: There are two cases. On one hand, for both entities, when their relationship is clearly mentioned in the article, but there is no option in the list, you can feed back to the developer to add the relationship. On the other hand, be associated with can be used when the author is also not clear about the relationship.

Q10: What is difference between Downregulated in, Reduced by, Alleviated by?

A10: Downregulated in - a reduction in the level of gene expression or a biological process Reduced by - a quantitative or numerical reduction Alleviated by - a reduction in the level of gene expression or a biological process -focused on disease alleviating symptoms or discomfort.

## Attention

- It is best to use Google Chrome to open the Prophet Label Studio website.

- Spaces that may be generated when marking are not allowed, for example, spaces before and after the highlighted markers in Long COVID should be avoided as much as possible and only the entity Long COVID is preferred.

- It is not necessary to repeat markup of a content (markup of the first occurrence of the ENTITY), but it has to be made explicit again in the KEY SENTENCES.

- Every article needs at least one key sentence (with two entities in it is preferred).

- Mark the full name of the entity + the abbreviation, and the content in parentheses as well, but common entities may not need to be marked with the full name, e.g., myalgic encephalomyelitis / chronic fatigue syndrome (ME/CFS), while some rare abbreviations must be marked with the full name to facilitate subsequent review.
