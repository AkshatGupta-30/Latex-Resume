\newif\if@normalphoto

\LoadClass{extarticle}

\RequirePackage{accsupp}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage[fixed]{fontawesome5}
\RequirePackage{ifxetex,ifluatex}


\RequirePackage{fontspec}


\RequirePackage{xcolor}

%* Colourful
% \colorlet{accent}{blue!70!black} 
% \colorlet{emphasis}{black}
% \colorlet{heading}{black}
% \colorlet{headingrule}{black}
% \colorlet{subheading}{emphasis}
% \colorlet{body}{black!80!white}
% \colorlet{name}{heading}
% \colorlet{tagline}{accent}
%*

%* Black And White
\colorlet{accent}{black}
\colorlet{emphasis}{black}
\colorlet{heading}{black}
\colorlet{headingrule}{black}
\colorlet{subheading}{emphasis}
\colorlet{body}{black!80!white}
\colorlet{name}{heading}
\colorlet{tagline}{accent}
%*


\newcommand{\cvLocationMarker}{\faMapMarker}

\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\RequirePackage[inline]{enumitem}

\setlength{\parindent}{0pt}

\newcommand{\utffriendlydetokenize}[1]{%
\scantokens{%
    \catcode`\_=12%
    {#1}%
}%
}

\ExplSyntaxOn
\NewDocumentCommand{\printinfo}{m m o}{%
    \IfNoValueTF{#3}{%
        \mbox{
        \textcolor{accent}%
            {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
            ~\utffriendlydetokenize{#2}\hspace{2em}
        }%
    }{%
        \mbox{\textcolor{accent}%
        {\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
        ~\href{#3}{\utffriendlydetokenize{#2}}\hspace{2em}}
    }%
}%


\NewDocumentCommand{\NewInfoField}{s m m o}{%
    \IfBooleanF{#1}{
        \IfNoValueF{#4}{\csdef{#2 hyperprefix}{#4}}%
    }
    \csdef{#2 symbol}{#3}%
    \IfBooleanTF{#1}
    { \csdef{#2}##1##2{%
            \printinfo{\csuse{#2 symbol}}{##1}%
        }%
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

\NewInfoField{orcid}{\faOrcid}[https://orcid.org/]
\NewInfoField{location}{\cvLocationMarker}


\newlength{\class@photos@width}
\newlength{\class@photo@diam}
\def\class@photos{}

\newcommand{\@makeaphoto}[2]{%
    \begin{minipage}{#1}%
        \if@normalphoto
        \setlength{\fboxsep}{0pt}%
        \setlength{\fboxrule}{1pt}%
        \fbox{\includegraphics[width=0.94\linewidth]{#2}}
        \else
        % \tikz\path[fill overzoom image={#2}]circle[radius=0.5\linewidth];
        \begin{tikzpicture}
            \node[circle,draw, very thick, color=black, minimum size=0.94\linewidth, 
            fill overzoom image=#2]{};
        \end{tikzpicture}
        \fi%
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

\newcommand{\namefont}{\Huge\bfseries}
% \newcommand{\taglinefont}{\large\bfseries}
\newcommand{\personalinfofont}{\small}

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
