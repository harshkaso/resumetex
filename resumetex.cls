% --------------------------------------------------------------------------------
% RESUMETEX
% AUTHOR: HARSH KASODARIYA
% LICENSE: MIT
% --------------------------------------------------------------------------------
\ProvidesClass{resumetex}[2026/08/22 v1.0 ResumeTeX resume class]
\LoadClass[11pt, letterpaper]{article}
% CUSTOM ENUMERATE/ITEMIZE LIST
\usepackage{enumitem}
% NO PAR(AGRAPH) INDENTATION
\usepackage[parfill]{parskip}
% CUSTOM DOCUMENT MARGINS
\usepackage[left=0.5in,top=0.5in,right=0.5in,bottom=0.5in]{geometry}
% FONT - CHARTER
\usepackage{charter}
% COLORED LINKS
\usepackage[colorlinks = true, linkcolor = blue, urlcolor  = blue, citecolor = blue, anchorcolor = blue]{hyperref}
% CUSTOMIZE TABULAR
\usepackage{tabularx}
% MACHINE-READABLE PDF
\input{glyphtounicode}
\pdfgentounicode=1
% NO PAGE NUMBERS
\pagestyle{empty}
% --------------------------------------------------------------------------------
% COMMANDS
% --------------------------------------------------------------------------------
% CONTACT INFO
\NewDocumentCommand{\SetContact}{ m m m m }{
  \newcommand{\ContactName}{#1}
  \newcommand{\ContactEmail}{#2}
  \newcommand{\ContactPhone}{#3}
  \newcommand{\ContactAddress}{#4}
}

% PROFESSIONAL SUMMARY
\NewDocumentCommand{\SetProfessionalSummary}{m}{
    \newcommand{\ProfessionalSummary}{#1}
}

\ExplSyntaxOn

\seq_new:N \g_resumetex_skills_seq
\seq_new:N \g_resumetex_experiences_seq
\seq_new:N \g_resumetex_projects_seq
\seq_new:N \g_resumetex_education_seq
\seq_new:N \g_resumetex_certifications_seq

% ADD SKILL TO THE LIST
% ARGS:
% 1 SKILL CATEGORY
% 2 SKILLS {comma separated list of skills: skill1, skill2, skill3 ... }
\NewDocumentCommand{\AddSkill}{ m m }{
    \seq_gput_right:Nn
        \g_resumetex_skills_seq
        {
            \textbf{#1} & #2
        }
}

% ADD EXPERIENCE TO THE LIST
% ARGS:
% 1 PAGE BREAK [optional]
% 2 JOB POSITION
% 3 COMPANY NAME
% 4 COMPANY LOCATION
% 5 START DATE
% 6 END DATE
% 7 ACCOMPLISHMENTS
\NewDocumentCommand{\AddExperience}{s m m m m m m}{
    \seq_gput_right:Nn
        \g_resumetex_experiences_seq
        {
            \IfBooleanT{#1}{\newpage}
            \textbf{#2},~#3,~#4 \hfill \textbf{#5~-~#6}
            \begin{itemize}[leftmargin=*,noitemsep,nolistsep]
                #7
            \end{itemize}
        }
}


% ADD PROJECT TO THE LIST
% ARGS:
% 1 PAGE BREAK [optional]
% 2 PROJECT NAME
% 3 START DATE
% 4 END DATE
% 5 ACCOMPLISHMENTS
% 6 ADDITIONAL INFO [optional]
\NewDocumentCommand{\AddProject}{s m m m +m o}{
    \seq_gput_right:Nn
        \g_resumetex_projects_seq
        {
            \IfBooleanT{#1}{\newpage}
            \textbf{#2}\IfNoValueTF{#6}{}{~---~#6} \hfill \textbf{#3~-~#4}
            \begin{itemize}[leftmargin=*,noitemsep,nolistsep]
                #5
            \end{itemize}
        }
}


% ADD EDUCATION TO THE LIST
% ARGS:
% 1 PAGE BREAK [optional]
% 2 DEGREE
% 3 UNIVERSITY/SCHOOL
% 4 UNIVERSITY LOCATION
% 5 START DATE
% 6 END DATE
% 7 COURSE WORK [optional]
\NewDocumentCommand{\AddEducation}{s m m m m m o}{
    \seq_gput_right:Nn
        \g_resumetex_education_seq
        {
            \textbf{#2},~#3,~#4 \hfill \textbf{#5~-~#6}
            \IfNoValueTF{#7}{}{
                \\
                --\hspace{0.5em}\textit{\textbf{Course Work}~---~#7}
            }
        }
}

% ADD CERTIFICATION TO THE LIST
% ARGS:
% 1 PAGE BREAK [optional]
% 2 CERTIFICATION NAME
% 3 HOST ORGANISATION
% 4 DATE EARNED
\NewDocumentCommand{\AddCertification}{s m m m}{
    \seq_gput_right:Nn \g_resumetex_certifications_seq
       {
        \IfBooleanT{#1}{\newpage}
        \textbf{#2}~---~\textit{#3} \hfill \textbf{#4}
       }
}

% DEFINE RESUME SECTION
\newenvironment{rSection}[1]{%
  \par\noindent{\large\scshape #1\par\medskip}
  \hrule
  \begin{list}{}{%
    \setlength{\leftmargin}{0pt}%
    \setlength{\itemsep}{0pt}%
    \setlength{\parsep}{0pt}%
  }
  \item[]
}{\end{list}}
% --------------------------------------------------------------------------------
% PRINT COMMANDS
% --------------------------------------------------------------------------------
% PRINT CONTACT INFO
\NewDocumentCommand{\PrintContact}{}{%
    \def\DiamondSep{\quad$\diamond$\quad}
    \centerline{\huge\textbf{\MakeUppercase{\ContactName}}}
    \vspace{1pt}
    \centerline{\ContactEmail\DiamondSep\ContactPhone\DiamondSep\ContactAddress}
}

% PRINT PROFESSIONAL SUMMARY
\NewDocumentCommand{\PrintSummary}{}{%
    \begin{rSection}{Summary}
        \ProfessionalSummary
    \end{rSection}
}

% PRINT SKILLS
\NewDocumentCommand{\PrintSkills}{}{
    \begin{rSection}{Skills}
        \begin{tabular}{ @{} >{\bfseries}l @{\hspace{3ex}} l }
            \seq_use:Nn \g_resumetex_skills_seq {\\}
        \end{tabular}
    \end{rSection}
}

% PRINT EXPERIENCES
\NewDocumentCommand{\PrintExperiences}{}{
    \begin{rSection}{Experience}
        \seq_use:Nn \g_resumetex_experiences_seq {\par\vspace{4pt}}
    \end{rSection}
}

% PRINT PROJECTS
\NewDocumentCommand{\PrintProjects}{}{
    \begin{rSection}{Projects}
        \seq_use:Nn \g_resumetex_projects_seq {\par\vspace{4pt}}
    \end{rSection}
}

% PRINT EDUCATION
\NewDocumentCommand{\PrintEducation}{}{
    \begin{rSection}{Education}
        \seq_use:Nn \g_resumetex_education_seq {\par\vspace{4pt}}
    \end{rSection}
}

% PRINT CERTIFICATIONS
\NewDocumentCommand{\PrintCertifications}{} {
    \begin{rSection}{Certifications}
        \seq_use:Nn \g_resumetex_certifications_seq {\\}
    \end{rSection}
}
\ExplSyntaxOff

