USE [master]
GO
/****** Object:  Database [dbWebApp]    Script Date: 14/7/2022 10:55:29 ******/
CREATE DATABASE [dbWebApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbWebApp', FILENAME = N'C:\Users\carlo\dbWebApp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbWebApp_log', FILENAME = N'C:\Users\carlo\dbWebApp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [dbWebApp] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbWebApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbWebApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbWebApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbWebApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbWebApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbWebApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbWebApp] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dbWebApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbWebApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbWebApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbWebApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbWebApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbWebApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbWebApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbWebApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbWebApp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbWebApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbWebApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbWebApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbWebApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbWebApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbWebApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbWebApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbWebApp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbWebApp] SET  MULTI_USER 
GO
ALTER DATABASE [dbWebApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbWebApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbWebApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbWebApp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbWebApp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbWebApp] SET QUERY_STORE = OFF
GO
USE [dbWebApp]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [dbWebApp]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 14/7/2022 10:55:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](100) NULL,
	[Status] [char](1) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ('A') FOR [Status]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  StoredProcedure [dbo].[SPConsultProduct]    Script Date: 14/7/2022 10:55:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SPConsultProduct]
AS
DECLARE
	@status char = 'A'
BEGIN TRY
	SET NOCOUNT ON;

	SELECT p.*
	FROM Products AS p
	WHERE p.[Status] = @status;
END TRY
BEGIN CATCH
	THROW;
END CATCH
GO
USE [master]
GO
ALTER DATABASE [dbWebApp] SET  READ_WRITE 
GO
