% !TEX program = xelatex
% !TeX encoding = UTF-8
% !TeX spellcheck = en_US
% !BIB program = biblatex
% 如果使用TexStudio,可以应当按照makefile自定义编译命令（选项/设置TexStudio/构建/用户命令(make,clean),see Figure`setting.png`

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{amsthesis}[2024/06/20 Academy of Military Science Thesis Template]
\def\version{1.0}
%检查是否由xelatex编译
\RequirePackage{ifxetex}
\ifxetex
\else
\ClassError{amsthesis}{You must have to use the 'xelatex', option path is 'Menu-->Compiler' \MessageBreak Please choose `xelatex'}{%
Only choose `xelatex', no `pdflatex' or `latex' and so on.}
\fi

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\newif\ifphd
\DeclareOption{phd}{\phdtrue}
\DeclareOption{master}{\phdfalse}
\ExecuteOptions{master} % 默认选项为硕士
\ProcessOptions\relax

% 正文字号为小四
\LoadClass[a4paper,UTF8,zihao=-4,scheme=chinese]{ctexbook}


% 建议在模板开始处载入全部宏包，不要轻易改变加载顺序。
% \pkg{hyperref} 一般在最后加载。
\RequirePackage{filehook} %provides hooks for input files
\RequirePackage{fancyhdr} % 页眉页脚
\RequirePackage{titletoc}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\graphicspath{{figures/},{images/} }  %指定figure路径
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}% 定理类环境宏包，其中 amsmath 选项用来兼容 AMS LaTeX 的宏包
\RequirePackage[ruled,linesnumbered]{algorithm2e}%%算法包，注意设置所需可选项
\renewcommand{\algorithmcfname}{算法}
\RequirePackage[driver=xetex]{geometry}
\RequirePackage{caption}
\RequirePackage{xcolor}    % 补充字体颜色
\RequirePackage[shortlabels]{enumitem}   % 列表格式
\setenumerate[1]{label={[\arabic*]},leftmargin=0pt,itemindent=4\ccwd,itemsep=0pt,topsep=0pt,parsep=0pt}
% 文献格式参考GB7714-2015标准,期刊不适用缩写
\RequirePackage[backend=biber,style=gb7714-2015,sorting=none,doi=false,abbreviate=false,gbalign=gb7714-2015,gbpub=false,gbnamefmt=lowercase]{biblatex}
\addbibresource{ref.bib}
% \RequirePackage[nohyperref]{acronym}   %缩略语表
% \RequirePackage{nomencl}   % 符号表
\RequirePackage{afterpage}
\RequirePackage{mathrsfs}       % 提供mathscr: 花体
\RequirePackage{amssymb}        % ams数学符号
\RequirePackage{booktabs}       % 表格，横的粗线；\specialrule{1pt}{0pt}{0pt}
\RequirePackage{ifthen}
% % ===========================================
% % 字体设置
% % ===========================================
% \setmainfont{Arial}         %我也不知道英文标题应该使用哪一种，Time New Roman or Arial
\setmainfont{Times New Roman}   % 英文字体是用Time New Roman
\setsansfont{Arial}             % 另外一种常用的英文字体
% \linespread{0.9}                % 全局行距设置
\newcommand{\rmnum}[1]{\romannumeral #1}  %罗马文字
\newcommand{\Rmnum}[1]{\expandafter\@slowromancap\romannumeral #1@}  %罗马文字
% \setstretch{1.25}  % 自定义行距倍数

% 不同操作系统下字体逻辑，具体内容参见doc\ctex.pdf说明

% window系统下主要使用window系统提供的字体：宋体、仿宋、黑体等
% Win系统以下内容取消注释
% \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold = {1.5}]
% \renewcommand{\songti}{\CJKfamily{zhsong}}  %中易宋体
% \renewcommand{\heiti}{\CJKfamily{zhhei}}  %中易黑体

% Overleaf 版本***,中文使用Fandol 字库。

% ===========================================
% 纸张和页面
% ===========================================
% 使用 \pkg{geometry} 宏包设置纸张和页面。
% 纸张：A4；
% 页面设置：上、下 2.5 cm，左、右 3.17 cm，
% 5号字高3.70mm

% 间距存在问题，手动测量设置出的结果
\geometry{
  paper      = a4paper,
  top    =  3.1cm,
  hmargin = 3.0cm,
  bottom = 3.1cm,
  headheight = 1.8cm,
  headsep    = -0.9cm,
  footskip   = 0.6cm,
}


% =======================
% 设置页眉页脚
% 全文除封面、原创性声明、中、英文扉页无页眉外，均采 用双实线页眉
% 宋体五号 字，居中，距边界 2 厘米;
% =======================
\newcommand{\doubleline}{%
  \makebox[0pt][l]{\rule[0.80\baselineskip]{\headwidth}{1.25pt}}%
  \rule[1\baselineskip]{\headwidth}{1.25pt}
}
\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt} % 去掉原始页眉单线
  \renewcommand{\footrulewidth}{1pt} % 页脚下单实线
  \fancyhead[C]{\songti \zihao{5} \selectfont {\ifphd 博士学位论文 \else 硕士学位论文 \fi}\vspace{3pt}\\
    \doubleline % 添加双线
  }
  \fancyfoot[C,C]{\songti\zihao{5} 第~\rmfamily{\thepage}~页}
}

\fancypagestyle{empty}{
  \fancyhf{}  % 清除所有页眉页脚
  \renewcommand{\headrulewidth}{0pt}  % 删除页眉线
  \renewcommand{\footrulewidth}{0pt}  % 删除页脚线
}

% ============================================================
% 前置部分，包括封面，中、英文扉页，原创性声明和使用授权声明
% ============================================================
% 封面，中、英文扉页，原创性声明和使用授权声明该部分太难编写，考虑直接使用word生成相应的目标pdf，然后再直接导入。


% ============================
% 中文摘要环境
% ============================
\newenvironment{abstract}{
  \chapter*{\centering\heiti\zihao{3}\selectfont{}摘\hspace{\ccwd}要}
  \setcounter{page}{1}
  \addcontentsline{toc}{chapter}{摘\hspace{\ccwd}要}  %添加摘要到目录
  \songti\zihao{-4}\setlength{\baselineskip}{20bp}\selectfont
}

% ============================
% 英文摘要环境
% ============================
\newenvironment{abstract*}{
  \chapter*{\centering\rmfamily\bfseries\zihao{3}\selectfont Abstract}%
  \addcontentsline{toc}{chapter}{\bfseries Abstract}
  \rmfamily\zihao{-4}\setlength{\baselineskip}{20bp}\selectfont
}{
  %\cleardoublepage
  \clearpage  % or \cleardoublepage
  \if@twoside
  \ifnumodd{\c@page}
  {\afterpage{\thispagestyle{empty}}}
  {\thispagestyle{empty}}
  \fi
}

% ============================
% 致谢环境,已取消
% ============================
% \newenvironment{acknowledgements}{
%     \chapter*{致\hspace{\ccwd}谢}
%     \addcontentsline{toc}{chapter}{致\hspace{\ccwd}谢}
%     \songti
% }{
%     \clearpage
% }


% ============================
% 目录格式设置
% ============================
% 目录:目录内容中文为黑体、英文为 Times New Roman 小四号字，
% 依次排列摘要、ABSTRACT、各章、节、致谢、参考文献、 附录等。
% \titlecontents{标题名}[左间距]{标题格式}{标题标志}{无序号标题}{指引线与页码}[下间距]
\contentsmargin{0em}     %页码靠右对齐
\titlecontents{chapter}[\z@]  %左间距
{\heiti\zihao{-4}\setlength{\baselineskip}{10bp}\selectfont}%标题字体格式
{\contentspush{\thecontentslabel\hspace{0.5em}}}
{\contentsmargin{0pt}}
{\titlerule*[3bp]{.}\thecontentspage} %指引线与页码
% [\vspace{0.25cm}]  %下间距
\titlecontents{section}[2\ccwd]
{\songti\zihao{-4}\setlength{\baselineskip}{10bp}\selectfont}
{\contentspush{\thecontentslabel\hspace{0.5em}}}
{\contentsmargin{0pt}}
{\titlerule*[3bp]{.}\thecontentspage}%
% [\vspace{0.25cm}]
\titlecontents{subsection}[4\ccwd]   %缩进
{\songti\zihao{-4}\setlength{\baselineskip}{10bp}\selectfont}
{\contentspush{\thecontentslabel\hspace{0.5em}}}
{}
{\titlerule*[3bp]{.}\thecontentspage}%
% [\vspace{0.25cm}]
\titlecontents{table}[0em]
{\songti\zihao{-4}\setlength{\baselineskip}{15bp}\selectfont}
{\contentspush{表\ \thecontentslabel\hspace{0.5em}}}
{}
{\titlerule*[3bp]{.}\thecontentspage}%
[\vspace{0.1cm}]      %条目之后的距离，实现行距调整
\titlecontents{figure}[0em]
{\songti\zihao{-4}\setlength{\baselineskip}{15bp}\selectfont}
{\contentspush{图\ \thecontentslabel\hspace{0.5em}}}
{}
{\titlerule*[3bp]{.}\thecontentspage}  % 右对齐的页码
[\vspace{0.1cm}]

% 重定义目录命令，修改标题格式并插入书签。
\RenewDocumentCommand \tableofcontents { }
{
  \raggedbottom
  \chapter*{\contentsname}
  %\thispagestyle{empty}
  \linespread{1.15}\selectfont   % 修改行间距，比如设置为1.2倍行距
  \@starttoc{toc}
  %\thispagestyle{empty}
  \linespread{1.0}\selectfont   % 恢复默认的行间距（可选）
}

% 正文内部图表标题设置
\DeclareCaptionFont{captionfont}{\songti\zihao{5}\selectfont}
\captionsetup[figure]{
  format         = hang,
  font           = captionfont,
  labelsep       = space,
  aboveskip      = 5pt,  %调整图表标题距离图表的距离
  belowskip      = 0pt,
  position = bottom,
}
\captionsetup[table]{
  format         = hang,
  font           = captionfont,
  labelsep       = space,
  aboveskip      = 5pt,   %调整图表标题距离图表的距离
  belowskip      = 0pt,
  position  = top,
}
% 调整浮动体（表格、图像等）与其他文字间的垂直间距
\setlength{\textfloatsep}{6pt plus 3.0pt minus 3.0pt} % 控制浮动图像/表格与文本之间的距离
\setlength{\floatsep}{6pt plus 3.0pt minus 3.0pt}     % 控制两个浮动体之间的距离
\setlength{\intextsep}{6pt plus 3.0pt minus 3.0pt}    % 控制浮动体与文本之间的距离（插入在文本中时）
% 设置默认布局格式为htb
% \DeclareFloatingEnvironment[fileext=lof]{figure}
% \DeclareFloatingEnvironment[fileext=lot]{table}
% \renewcommand{\fps@figure}{htb}
% \renewcommand{\fps@table}{htb}

% “目录”,“摘要”、各章标题、“致谢”、“参考文献”， “附录题目”等为黑体三号字，“ABSTRACT” 为 Times New Roman 加黑四号字，居中，2 倍行距，段前 2 行，段后 1 行。
% 各节标题为黑体四号字，各小节标题为黑体小四号字，均靠左
% 用 \pkg{ctex} 的接口设置全部章节标题格式。
\ctexset{
  contentsname = {目\hspace{\ccwd}录},
  listfigurename ={\heiti\zihao{3}图~~目~~录},
  listtablename ={\heiti\zihao{3}表~~目~~录},
  secnumdepth=subsubsection,
  chapter = {
    format  = \centering\heiti\zihao{3}\selectfont,
    name = {第,章},
    number      = \chinese{chapter},
    aftername   = \hspace{\ccwd},
    beforeskip  = 0.5\baselineskip,
    afterskip   = 1\baselineskip,
    break = {\clearpage},%
    % fixskip=true,
    lofskip=0pt,
    lotskip=0pt,
  },
  section = {
    numberformat = \rmfamily\zihao{4}\selectfont,
    titleformat=\songti\zihao{4}\selectfont,
    aftername  = \hspace{0.5\ccwd},
    beforeskip  = 1.5\baselineskip,
    afterskip   = 1\baselineskip,
    % fixskip=true,
  },
  subsection = {
    numberformat = \rmfamily\zihao{-4}\selectfont,
    titleformat= \heiti\zihao{-4}\selectfont,
    aftername  = \hspace{0.5\ccwd},
    beforeskip = 1\baselineskip,
    afterskip  = 1\baselineskip,
    indent=\parindent,
  },
  subsubsection={
    numberformat = \rmfamily\zihao{-4}\selectfont,
    titleformat= \heiti\zihao{-4}\selectfont,
    aftername  = \hspace{0.5\ccwd},
    beforeskip = 1\baselineskip,
    afterskip  = 0\baselineskip,
    indent=\parindent,
  }
}


\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
  \pagestyle{plain}  % 或者使用你定义的前言页面样式
}

\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagestyle{plain}
  \pagenumbering{arabic}%
  \songti\zihao{-4}\setlength{\baselineskip}{20bp}\selectfont
}

\RequirePackage{hyperref}
\AtEndOfPackageFile*{hyperref}{
  \hypersetup{
    linktoc            = all,
    bookmarksdepth     = 2,
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1,
    bookmarksdepth     = 3,
    unicode            = true,
    psdextra           = true,
    breaklinks         = true,
    plainpages         = false,
    pdfdisplaydoctitle = true,
    hidelinks,
  }%

  \pdfstringdefDisableCommands{
    \let\\\relax
    \let\quad\relax
    \let\qquad\relax
    \let\hspace\@gobble
  }%
  \@ifpackagelater{hyperref}{2019/04/27}{}{%
    \g@addto@macro\psdmapshortnames{\let\mu\textmu}
  }%
  \hypersetup{
    pdflang = zh-CN,
  }
}

% ============================
% 参考文献格式
% ============================
% \PassOptionsToClass{}{biblatex}
\def\bibfont{\rmfamily\zihao{-4}\selectfont}   %
\defbibenvironment{bibliography}
%{\begin{enumerate}[itemindent=4\ccwd]      %首行缩进
{
  \begin{enumerate}[itemindent=0pt,leftmargin=2.5\ccwd]   % 悬挂缩进，我认为比首行缩进要干净整齐很多。
      \setlength{\baselineskip}{16bp}  % 修改参考文献的行距等
      {}  % 在环境开始时设置行距
      {   \setlength{\leftmargin}{0pt}%
        \setlength{
      \itemindent}{\bibhang}%
        \setlength{
      \itemsep}{\bibitemsep}%
    \setlength{\parsep}{\bibparsep}}}
    {\endenumerate}
    {
  \item}




    % ============================
    % 提供一些常用命令
    % ============================
    \DeclareRobustCommand\cmd[1]{\texttt{#1}}
    \DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
    \DeclareRobustCommand\file{\nolinkurl}
    \DeclareRobustCommand\env{\textsf}
    \DeclareRobustCommand\pkg{\textsf}
    \DeclareRobustCommand\cls{\textsf}



    % ============================
    %相关环境设置
    % ============================
    \theoremstyle{plain}
    \theorembodyfont{\songti\rmfamily}
    \theoremheaderfont{\heiti\rmfamily}
    \newtheorem{definition}{\heiti 定义}[chapter]
    \newtheorem{property}{\heiti 性质}[chapter]
    \newtheorem{example}{\heiti 例}[chapter]
    \newtheorem{algo}{\heiti 算法}[chapter]
    \newtheorem{theorem}{\heiti 定理}[chapter]
    \newtheorem{axiom}{\heiti 公理}[chapter]
    \newtheorem{proposition}{\heiti 命题}[chapter]
    \newtheorem{lemma}{\heiti 引理}[chapter]
    \newtheorem{corollary}{\heiti 推论}[chapter]
    \newtheorem{remark}{\heiti 注解}[chapter]
    \newenvironment{proof}{\noindent{\heiti 证明：}}{\hfill $ \square $ \vskip 4mm}
    \theoremsymbol{$\square$}
