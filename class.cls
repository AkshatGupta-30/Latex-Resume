\LoadClass{extarticle}

\RequirePackage{accsupp}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage[fixed]{fontawesome5}
\RequirePackage{fontspec}
\RequirePackage{xcolor}

\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\usepackage{pifont}
\RequirePackage[inline]{enumitem}
\RequirePackage{xcolor}
\usepackage{hyperref}

\input{fonts}

\colorlet{accent}{black}
\colorlet{emphasis}{black}
\colorlet{heading}{black}
\colorlet{headingrule}{black}
\colorlet{subheading}{emphasis}
\colorlet{body}{black!80!white}
\colorlet{name}{heading}
\colorlet{tagline}{accent}

%* Header
\newcommand{\cvLocationMarker}{\faMapMarker}
\setlength{\parindent}{0pt}

\newcommand{\utffriendlydetokenize}[1]{%
\scantokens{%
    \catcode`\_=12%
    \catcode`\^=12%
    \catcode`\_=12%
    \catcode`\:=12%
    \catcode`\-=12%
    \catcode`\&=12%
    \catcode`\$=12%
    \catcode`\#=12%
    \catcode`\~=12%
    \catcode`\\=12%
    {#1}%
}%
}

\ExplSyntaxOn
\NewDocumentCommand{\printinfo}{m m o}{%
    \mbox{
        \textcolor{accent}%
        {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
        ~\utffriendlydetokenize{#2}\hspace{2em}
    }%
    \vspace{0.2mm}
}%
\NewDocumentCommand{\NewInfoField}{s m m o}{
    \csdef{#2 symbol}{#3}%
    \IfBooleanTF{#1}
    { \csdef{#2}##1##2{%
            \printinfo{\csuse{#2 symbol}}{##1}%
        }
    }
    { \csdef{#2}##1{%
            \printinfo{\csuse{#2 symbol}}{##1}%
        }%
    }
}
\ExplSyntaxOff

\newcommand{\name}[1]{\def\@name{#1}}
% \newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}
\NewInfoField{email}{\faAt}[mailto:]
\NewInfoField{mailaddress}{\faEnvelope}
\NewInfoField{phone}{\faPhone}[tel:]
\NewInfoField{homepage}{\faGlobe}[https://]
\NewInfoField{twitter}{\faTwitter}[https://twitter.com/]
\NewInfoField{linkedin}{\faLinkedin}[https://linkedin.com/in/]
\NewInfoField{github}{\faGithub}[https://github.com/]
\NewInfoField{location}{\cvLocationMarker}


\newlength{\class@photos@width}
\newlength{\class@photo@diam}
\def\class@photos{}

\newcommand{\@makeaphoto}[2]{%
    \begin{minipage}{#1}%
        \begin{tikzpicture}
            \node[circle,draw, very thick, color=black, minimum size=0.94\linewidth, 
            fill overzoom image=#2]{};
        \end{tikzpicture}
    \end{minipage}%
}

\newcommand{\class@add@photo}[1]{%
    \appto{\class@photos}{%
        \@makeaphoto{\class@photo@diam}{#1}\hspace{1ex}%
    }%
    \addtolength{\class@photos@width}{\class@photo@diam}%
    \addtolength{\class@photos@width}{1ex}%
}
\newcommand{\photo}[2]{%
    \setlength{\class@photo@diam}{#1}%
    \forcsvlist{\class@add@photo}{#2}%
}

\newcommand{\namefont}{\fontsize{35}{60}\selectfont\bfseries\rubik}
% \newcommand{\taglinefont}{\large\bfseries}
\newcommand{\personalinfofont}{\small\robotoslab}

\newcommand{\makecvheader}{%
    \begingroup
        \begin{minipage}{\dimexpr\linewidth-\class@photos@width}%
        \raggedright%
        {\namefont\color{name}\MakeUppercase{\@name}\par}
        \medskip
        % {\taglinefont\color{tagline}\@tagline\par}
        % \medskip
        {\personalinfofont\@personalinfo\par}
        \end{minipage}\hfill%
        \class@photos\par%
    \endgroup\medskip
}
%*

\setlist{leftmargin=0.65cm,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}

\newcommand{\sectionheading}[2][]{%
    \nointerlineskip\bigskip%  %% bugfix in v1.6.2
    \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
    {\color{heading}\fontsize{20}{60}\selectfont\bfseries\josefinsans{#2}}\\[-1ex]%
    {\color{headingrule}\rule{\linewidth}{2pt}\par}\medskip
}

\newcommand{\strengthlist}[1]{
    \begin{itemize}
        \makeatletter
        \@for\strength:=#1\do{\item[\ding{70}] \strength}
        \makeatother
    \end{itemize}
}

\newcommand{\skilllist}[2]{
    \begin{minipage}[t]{#1}
        \begin{itemize}
        \foreach \x in {#2} {
            \item[] \x
        }
        \end{itemize}
    \end{minipage}
}

\newcommand{\skillsection}[2]{
    \skilllist{2cm}{#1}
    \hfill
    \skilllist{3cm}{#2}
}

\newcommand{\education}[4]{
    \textbf{\fontsize{11}{60}\selectfont{#1}} \\
    \textbf{\fontsize{9}{60}\selectfont{#2}} \\
    \fontsize{8}{60}\selectfont{#3} \\
    \normalsize{#4}
}

\newcommand{\certificate}[3]{
    #1\hspace{1.5mm}-\hspace{1.5mm}#2\hspace{2mm}\href{#3}{\textcolor{blue}{[Link]}}\\
    \vspace{-\baselineskip}
}

\newcommand{\aboutme}[1]{
    #1
}

\newcommand{\experience}[6]{
    \item[\ding{42}] {
        {\fontsize{14}{60}\selectfont{\textbf{#1}}}\\
        {\fontsize{12}{60}\selectfont{#2}}\\
        {\fontsize{9}{60}\selectfont{\faIcon[regular]{calendar} #3 \- #4 \hfill{\faMapMarker #5}}}
        \vspace{1mm}
        #6
    }
}

\newcommand{\project}[4]{
    \item[\raisebox{0.25\height}{\large{\ding{228}}}] {
        {\fontsize{15}{60}\selectfont{\textbf{#1}}}\hspace{0.75mm} \textit{\fontsize{11}{60}\selectfont{(#3)}} \hfill{\href{#2}{\textcolor{blue}{[Link]}}}
        \vspace{1mm}
        #4
        \vspace{1mm}
    }
}

\newcommand{\projectongoing}[3]{
    \item[\raisebox{0.25\height}{\large{\ding{228}}}] {
        {\fontsize{15}{60}\selectfont{\textbf{#1}}} \hspace{0.75mm} \textit{\fontsize{11}{60}\selectfont{(#2)}} \hfill [Ongoing]
        \vspace{1mm}
        #3
        \vspace{1mm}
    }
}