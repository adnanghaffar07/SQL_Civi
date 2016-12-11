-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 22, 2016 at 01:40 PM
-- Server version: 5.7.15-0ubuntu0.16.04.1
-- PHP Version: 5.6.27-1+deb.sury.org~xenial+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `civicrmTest`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';

--
-- Dumping data for table `actions`
--

INSERT INTO `actions` (`aid`, `type`, `callback`, `parameters`, `label`) VALUES
('comment_publish_action', 'comment', 'comment_publish_action', '', 'Publish comment'),
('comment_save_action', 'comment', 'comment_save_action', '', 'Save comment'),
('comment_unpublish_action', 'comment', 'comment_unpublish_action', '', 'Unpublish comment'),
('node_make_sticky_action', 'node', 'node_make_sticky_action', '', 'Make content sticky'),
('node_make_unsticky_action', 'node', 'node_make_unsticky_action', '', 'Make content unsticky'),
('node_promote_action', 'node', 'node_promote_action', '', 'Promote content to front page'),
('node_publish_action', 'node', 'node_publish_action', '', 'Publish content'),
('node_save_action', 'node', 'node_save_action', '', 'Save content'),
('node_unpromote_action', 'node', 'node_unpromote_action', '', 'Remove content from front page'),
('node_unpublish_action', 'node', 'node_unpublish_action', '', 'Unpublish content'),
('og_membership_delete_action', 'og_membership', 'og_membership_delete_action', '', 'Remove from group'),
('system_block_ip_action', 'user', 'system_block_ip_action', '', 'Ban IP address of current user'),
('user_block_user_action', 'user', 'user_block_user_action', '', 'Block current user');

-- --------------------------------------------------------

--
-- Table structure for table `authmap`
--

CREATE TABLE `authmap` (
  `aid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';

-- --------------------------------------------------------

--
-- Table structure for table `batch`
--

CREATE TABLE `batch` (
  `bid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';

-- --------------------------------------------------------

--
-- Table structure for table `block`
--

CREATE TABLE `block` (
  `bid` int(11) NOT NULL COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';

--
-- Dumping data for table `block`
--

INSERT INTO `block` (`bid`, `module`, `delta`, `theme`, `status`, `weight`, `region`, `custom`, `visibility`, `pages`, `title`, `cache`) VALUES
(1, 'system', 'main', 'bartik', 1, 0, 'content', 0, 0, '', '', -1),
(2, 'search', 'form', 'bartik', 1, -1, 'sidebar_first', 0, 0, '', '', -1),
(3, 'node', 'recent', 'seven', 1, 10, 'dashboard_main', 0, 0, '', '', -1),
(4, 'user', 'login', 'bartik', 1, 0, 'sidebar_first', 0, 0, '', '', -1),
(5, 'system', 'navigation', 'bartik', 1, 0, 'sidebar_first', 0, 0, '', '', -1),
(6, 'system', 'powered-by', 'bartik', 1, 10, 'footer', 0, 0, '', '', -1),
(7, 'system', 'help', 'bartik', 1, 0, 'help', 0, 0, '', '', -1),
(8, 'system', 'main', 'seven', 1, 0, 'content', 0, 0, '', '', -1),
(9, 'system', 'help', 'seven', 1, 0, 'help', 0, 0, '', '', -1),
(10, 'user', 'login', 'seven', 1, 10, 'content', 0, 0, '', '', -1),
(11, 'user', 'new', 'seven', 1, 0, 'dashboard_sidebar', 0, 0, '', '', -1),
(12, 'search', 'form', 'seven', 1, -10, 'dashboard_sidebar', 0, 0, '', '', -1),
(13, 'comment', 'recent', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(14, 'node', 'syndicate', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(15, 'node', 'recent', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(16, 'shortcut', 'shortcuts', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(17, 'system', 'management', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(18, 'system', 'user-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(19, 'system', 'main-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(20, 'user', 'new', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(21, 'user', 'online', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(22, 'comment', 'recent', 'seven', 1, 0, 'dashboard_inactive', 0, 0, '', '', 1),
(23, 'node', 'syndicate', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(24, 'shortcut', 'shortcuts', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(25, 'system', 'powered-by', 'seven', 0, 10, '-1', 0, 0, '', '', -1),
(26, 'system', 'navigation', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(27, 'system', 'management', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(28, 'system', 'user-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(29, 'system', 'main-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(30, 'user', 'online', 'seven', 1, 0, 'dashboard_inactive', 0, 0, '', '', -1),
(31, 'civicrm', '2', 'bartik', 1, -99, 'sidebar_first', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(32, 'civicrm', '3', 'bartik', 1, -98, 'sidebar_first', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(33, 'civicrm', '5', 'bartik', 1, -96, 'sidebar_first', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(34, 'civicrm', '7', 'bartik', 0, -94, '-1', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(35, 'civicrm', '2', 'seven', 1, -99, 'sidebar_first', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(36, 'civicrm', '3', 'seven', 1, -98, 'sidebar_first', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(37, 'civicrm', '5', 'seven', 1, -96, 'sidebar_first', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(38, 'civicrm', '7', 'seven', 0, -94, '-1', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(39, 'civicrm', '6', 'bartik', 0, -95, '-1', 0, 1, 'civicrm\ncivicrm/*', '', -1),
(40, 'civicrm', '6', 'seven', 0, -95, '-1', 0, 1, 'civicrm\ncivicrm/*', '', -1);

-- --------------------------------------------------------

--
-- Table structure for table `blocked_ips`
--

CREATE TABLE `blocked_ips` (
  `iid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';

-- --------------------------------------------------------

--
-- Table structure for table `block_custom`
--

CREATE TABLE `block_custom` (
  `bid` int(10) UNSIGNED NOT NULL COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';

-- --------------------------------------------------------

--
-- Table structure for table `block_node_type`
--

CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';

-- --------------------------------------------------------

--
-- Table structure for table `block_role`
--

CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'The user’s role ID from users_roles.rid.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_admin_menu`
--

CREATE TABLE `cache_admin_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for Administration menu to store client-side...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_block`
--

CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_bootstrap`
--

CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_entity_og_membership`
--

CREATE TABLE `cache_entity_og_membership` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store og_membership entity records.';

-- --------------------------------------------------------

--
-- Table structure for table `cache_entity_og_membership_type`
--

CREATE TABLE `cache_entity_og_membership_type` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store og_membership_type entity records.';

-- --------------------------------------------------------

--
-- Table structure for table `cache_field`
--

CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Field module to store already built...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_filter`
--

CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_form`
--

CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_image`
--

CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_menu`
--

CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_page`
--

CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_path`
--

CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';

-- --------------------------------------------------------

--
-- Table structure for table `cache_rules`
--

CREATE TABLE `cache_rules` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the rules engine to store configured items.';

-- --------------------------------------------------------

--
-- Table structure for table `cache_update`
--

CREATE TABLE `cache_update` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Update module to store information...';

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `cid` int(11) NOT NULL COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';

-- --------------------------------------------------------

--
-- Table structure for table `ctools_css_cache`
--

CREATE TABLE `ctools_css_cache` (
  `cid` varchar(128) NOT NULL COMMENT 'The CSS ID this cache object belongs to.',
  `filename` varchar(255) DEFAULT NULL COMMENT 'The filename this CSS is stored in.',
  `css` longtext COMMENT 'CSS being stored.',
  `filter` tinyint(4) DEFAULT NULL COMMENT 'Whether or not this CSS needs to be filtered.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store CSS that must be non-volatile.';

-- --------------------------------------------------------

--
-- Table structure for table `ctools_object_cache`
--

CREATE TABLE `ctools_object_cache` (
  `sid` varchar(64) NOT NULL COMMENT 'The session ID this cache object belongs to.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the object this cache is attached to.',
  `obj` varchar(128) NOT NULL COMMENT 'The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache.',
  `updated` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The time this cache was created or updated.',
  `data` longblob COMMENT 'Serialized data being stored.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store objects that are being...';

-- --------------------------------------------------------

--
-- Table structure for table `date_formats`
--

CREATE TABLE `date_formats` (
  `dfid` int(10) UNSIGNED NOT NULL COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';

--
-- Dumping data for table `date_formats`
--

INSERT INTO `date_formats` (`dfid`, `format`, `type`, `locked`) VALUES
(1, 'Y-m-d H:i', 'short', 1),
(2, 'm/d/Y - H:i', 'short', 1),
(3, 'd/m/Y - H:i', 'short', 1),
(4, 'Y/m/d - H:i', 'short', 1),
(5, 'd.m.Y - H:i', 'short', 1),
(6, 'm/d/Y - g:ia', 'short', 1),
(7, 'd/m/Y - g:ia', 'short', 1),
(8, 'Y/m/d - g:ia', 'short', 1),
(9, 'M j Y - H:i', 'short', 1),
(10, 'j M Y - H:i', 'short', 1),
(11, 'Y M j - H:i', 'short', 1),
(12, 'M j Y - g:ia', 'short', 1),
(13, 'j M Y - g:ia', 'short', 1),
(14, 'Y M j - g:ia', 'short', 1),
(15, 'D, Y-m-d H:i', 'medium', 1),
(16, 'D, m/d/Y - H:i', 'medium', 1),
(17, 'D, d/m/Y - H:i', 'medium', 1),
(18, 'D, Y/m/d - H:i', 'medium', 1),
(19, 'F j, Y - H:i', 'medium', 1),
(20, 'j F, Y - H:i', 'medium', 1),
(21, 'Y, F j - H:i', 'medium', 1),
(22, 'D, m/d/Y - g:ia', 'medium', 1),
(23, 'D, d/m/Y - g:ia', 'medium', 1),
(24, 'D, Y/m/d - g:ia', 'medium', 1),
(25, 'F j, Y - g:ia', 'medium', 1),
(26, 'j F Y - g:ia', 'medium', 1),
(27, 'Y, F j - g:ia', 'medium', 1),
(28, 'j. F Y - G:i', 'medium', 1),
(29, 'l, F j, Y - H:i', 'long', 1),
(30, 'l, j F, Y - H:i', 'long', 1),
(31, 'l, Y,  F j - H:i', 'long', 1),
(32, 'l, F j, Y - g:ia', 'long', 1),
(33, 'l, j F Y - g:ia', 'long', 1),
(34, 'l, Y,  F j - g:ia', 'long', 1),
(35, 'l, j. F Y - G:i', 'long', 1);

-- --------------------------------------------------------

--
-- Table structure for table `date_format_locale`
--

CREATE TABLE `date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';

-- --------------------------------------------------------

--
-- Table structure for table `date_format_type`
--

CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';

--
-- Dumping data for table `date_format_type`
--

INSERT INTO `date_format_type` (`type`, `title`, `locked`) VALUES
('long', 'Long', 1),
('medium', 'Medium', 1),
('short', 'Short', 1);

-- --------------------------------------------------------

--
-- Table structure for table `field_config`
--

CREATE TABLE `field_config` (
  `id` int(11) NOT NULL COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `field_config`
--

INSERT INTO `field_config` (`id`, `field_name`, `type`, `module`, `active`, `storage_type`, `storage_module`, `storage_active`, `locked`, `data`, `cardinality`, `translatable`, `deleted`) VALUES
(1, 'comment_body', 'text_long', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a373a22636f6d6d656e74223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0),
(2, 'body', 'text_with_summary', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a343a226e6f6465223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0),
(3, 'field_tags', 'taxonomy_term_reference', 'taxonomy', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a383a2273657474696e6773223b613a313a7b733a31343a22616c6c6f7765645f76616c756573223b613a313a7b693a303b613a323a7b733a31303a22766f636162756c617279223b733a343a2274616773223b733a363a22706172656e74223b693a303b7d7d7d733a31323a22656e746974795f7479706573223b613a303a7b7d733a31323a227472616e736c617461626c65223b623a303b733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a333a22746964223b613a323a7b733a353a227461626c65223b733a31383a227461786f6e6f6d795f7465726d5f64617461223b733a373a22636f6c756d6e73223b613a313a7b733a333a22746964223b733a333a22746964223b7d7d7d733a373a22696e6465786573223b613a313a7b733a333a22746964223b613a313a7b693a303b733a333a22746964223b7d7d7d, -1, 0, 0),
(4, 'field_image', 'image', 'image', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a373a22696e6465786573223b613a313a7b733a333a22666964223b613a313a7b693a303b733a333a22666964223b7d7d733a383a2273657474696e6773223b613a323a7b733a31303a227572695f736368656d65223b733a363a227075626c6963223b733a31333a2264656661756c745f696d616765223b623a303b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22656e746974795f7479706573223b613a303a7b7d733a31323a227472616e736c617461626c65223b623a303b733a31323a22666f726569676e206b657973223b613a313a7b733a333a22666964223b613a323a7b733a353a227461626c65223b733a31323a2266696c655f6d616e61676564223b733a373a22636f6c756d6e73223b613a313a7b733a333a22666964223b733a333a22666964223b7d7d7d7d, 1, 0, 0),
(5, 'og_membership_request', 'text_long', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a31333a226f675f6d656d62657273686970223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `field_config_instance`
--

CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `field_config_instance`
--

INSERT INTO `field_config_instance` (`id`, `field_id`, `field_name`, `entity_type`, `bundle`, `data`, `deleted`) VALUES
(1, 1, 'comment_body', 'comment', 'comment_node_page', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(2, 2, 'body', 'node', 'page', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b693a2d343b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(3, 1, 'comment_body', 'comment', 'comment_node_article', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(4, 2, 'body', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b693a2d343b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(5, 3, 'field_tags', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a343a2254616773223b733a31313a226465736372697074696f6e223b733a36333a22456e746572206120636f6d6d612d736570617261746564206c697374206f6620776f72647320746f20646573637269626520796f757220636f6e74656e742e223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32313a227461786f6e6f6d795f6175746f636f6d706c657465223b733a363a22776569676874223b693a2d343b733a383a2273657474696e6773223b613a323a7b733a343a2273697a65223b693a36303b733a31373a226175746f636f6d706c6574655f70617468223b733a32313a227461786f6e6f6d792f6175746f636f6d706c657465223b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b693a31303b733a353a226c6162656c223b733a353a2261626f7665223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a353a7b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b693a31303b733a353a226c6162656c223b733a353a2261626f7665223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a303b7d, 0),
(6, 4, 'field_image', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a353a22496d616765223b733a31313a226465736372697074696f6e223b733a34303a2255706c6f616420616e20696d61676520746f20676f207769746820746869732061727469636c652e223b733a383a227265717569726564223b623a303b733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a31313a226669656c642f696d616765223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b623a313b733a31313a227469746c655f6669656c64223b733a303a22223b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a353a226c61726765223b733a31303a22696d6167655f6c696e6b223b733a303a22223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a363a226d656469756d223b733a31303a22696d6167655f6c696e6b223b733a373a22636f6e74656e74223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d7d7d, 0),
(7, 5, 'og_membership_request', 'og_membership', 'og_membership_type_default', 0x613a363a7b733a353a226c6162656c223b733a31353a2252657175657374206d657373616765223b733a31313a226465736372697074696f6e223b733a36313a225468697320697320746865207465787420612075736572206d61792073656e6420746f207468652067726f75702061646d696e6973747261746f72732e223b733a383a227265717569726564223b623a303b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d7d, 0);

-- --------------------------------------------------------

--
-- Table structure for table `field_data_body`
--

CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';

-- --------------------------------------------------------

--
-- Table structure for table `field_data_comment_body`
--

CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';

-- --------------------------------------------------------

--
-- Table structure for table `field_data_field_image`
--

CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) UNSIGNED DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) UNSIGNED DEFAULT NULL COMMENT 'The height of the image in pixels.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';

-- --------------------------------------------------------

--
-- Table structure for table `field_data_field_tags`
--

CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';

-- --------------------------------------------------------

--
-- Table structure for table `field_data_og_membership_request`
--

CREATE TABLE `field_data_og_membership_request` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `og_membership_request_value` longtext,
  `og_membership_request_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 5 (og_membership_request)';

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_body`
--

CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_comment_body`
--

CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_field_image`
--

CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) UNSIGNED DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) UNSIGNED DEFAULT NULL COMMENT 'The height of the image in pixels.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_field_tags`
--

CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_og_membership_request`
--

CREATE TABLE `field_revision_og_membership_request` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `og_membership_request_value` longtext,
  `og_membership_request_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 5 (og_membership_request)';

-- --------------------------------------------------------

--
-- Table structure for table `file_managed`
--

CREATE TABLE `file_managed` (
  `fid` int(10) UNSIGNED NOT NULL COMMENT 'File ID.',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';

-- --------------------------------------------------------

--
-- Table structure for table `file_usage`
--

CREATE TABLE `file_usage` (
  `fid` int(10) UNSIGNED NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';

-- --------------------------------------------------------

--
-- Table structure for table `filter`
--

CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';

--
-- Dumping data for table `filter`
--

INSERT INTO `filter` (`format`, `module`, `name`, `weight`, `status`, `settings`) VALUES
('filtered_html', 'filter', 'filter_autop', 2, 1, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_html', 1, 1, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('filtered_html', 'filter', 'filter_htmlcorrector', 10, 1, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_url', 0, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('full_html', 'filter', 'filter_autop', 1, 1, 0x613a303a7b7d),
('full_html', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('full_html', 'filter', 'filter_htmlcorrector', 10, 1, 0x613a303a7b7d),
('full_html', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('full_html', 'filter', 'filter_url', 0, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('plain_text', 'filter', 'filter_autop', 2, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('plain_text', 'filter', 'filter_htmlcorrector', 10, 0, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_html_escape', 0, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_url', 1, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d);

-- --------------------------------------------------------

--
-- Table structure for table `filter_format`
--

CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';

--
-- Dumping data for table `filter_format`
--

INSERT INTO `filter_format` (`format`, `name`, `cache`, `status`, `weight`) VALUES
('filtered_html', 'Filtered HTML', 1, 1, 0),
('full_html', 'Full HTML', 1, 1, 1),
('plain_text', 'Plain text', 1, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `flood`
--

CREATE TABLE `flood` (
  `fid` int(11) NOT NULL COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';

-- --------------------------------------------------------

--
-- Table structure for table `image_effects`
--

CREATE TABLE `image_effects` (
  `ieid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';

-- --------------------------------------------------------

--
-- Table structure for table `image_styles`
--

CREATE TABLE `image_styles` (
  `isid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';

-- --------------------------------------------------------

--
-- Table structure for table `menu_custom`
--

CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';

--
-- Dumping data for table `menu_custom`
--

INSERT INTO `menu_custom` (`menu_name`, `title`, `description`) VALUES
('main-menu', 'Main menu', 'The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.'),
('management', 'Management', 'The <em>Management</em> menu contains links for administrative tasks.'),
('navigation', 'Navigation', 'The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.'),
('user-menu', 'User menu', 'The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.');

-- --------------------------------------------------------

--
-- Table structure for table `menu_links`
--

CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) UNSIGNED NOT NULL COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';

--
-- Dumping data for table `menu_links`
--

INSERT INTO `menu_links` (`menu_name`, `mlid`, `plid`, `link_path`, `router_path`, `link_title`, `options`, `module`, `hidden`, `external`, `has_children`, `expanded`, `weight`, `depth`, `customized`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `updated`) VALUES
('management', 1, 0, 'admin', 'admin', 'Administration', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 9, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 2, 0, 'user', 'user', 'User account', 0x613a313a7b733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, -10, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 3, 0, 'comment/%', 'comment/%', 'Comment permalink', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 4, 0, 'filter/tips', 'filter/tips', 'Compose tips', 0x613a303a7b7d, 'system', 1, 0, 1, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 5, 0, 'node/%', 'node/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 6, 0, 'node/add', 'node/add', 'Add content', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 7, 1, 'admin/appearance', 'admin/appearance', 'Appearance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33333a2253656c65637420616e6420636f6e66696775726520796f7572207468656d65732e223b7d7d, 'system', 0, 0, 0, 0, -6, 2, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 8, 1, 'admin/config', 'admin/config', 'Configuration', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32303a2241646d696e69737465722073657474696e67732e223b7d7d, 'system', 0, 0, 1, 0, 0, 2, 0, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 9, 1, 'admin/content', 'admin/content', 'Content', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33323a2241646d696e697374657220636f6e74656e7420616e6420636f6d6d656e74732e223b7d7d, 'system', 0, 0, 1, 0, -10, 2, 0, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 10, 2, 'user/register', 'user/register', 'Create new account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 10, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 11, 1, 'admin/dashboard', 'admin/dashboard', 'Dashboard', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33343a225669657720616e6420637573746f6d697a6520796f75722064617368626f6172642e223b7d7d, 'system', 0, 0, 0, 0, -15, 2, 0, 1, 11, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 12, 1, 'admin/help', 'admin/help', 'Help', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a225265666572656e636520666f722075736167652c20636f6e66696775726174696f6e2c20616e64206d6f64756c65732e223b7d7d, 'system', 0, 0, 0, 0, 9, 2, 0, 1, 12, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 13, 1, 'admin/index', 'admin/index', 'Index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -18, 2, 0, 1, 13, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 14, 2, 'user/login', 'user/login', 'Log in', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 15, 0, 'user/logout', 'user/logout', 'Log out', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 10, 1, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 16, 1, 'admin/modules', 'admin/modules', 'Modules', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32363a22457874656e6420736974652066756e6374696f6e616c6974792e223b7d7d, 'system', 0, 0, 0, 0, -2, 2, 0, 1, 16, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 17, 0, 'user/%', 'user/%', 'My account', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 18, 1, 'admin/people', 'admin/people', 'People', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a224d616e6167652075736572206163636f756e74732c20726f6c65732c20616e64207065726d697373696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -4, 2, 0, 1, 18, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 19, 1, 'admin/reports', 'admin/reports', 'Reports', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33343a2256696577207265706f7274732c20757064617465732c20616e64206572726f72732e223b7d7d, 'system', 0, 0, 1, 0, 5, 2, 0, 1, 19, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 20, 2, 'user/password', 'user/password', 'Request new password', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 20, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 21, 1, 'admin/structure', 'admin/structure', 'Structure', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a2241646d696e697374657220626c6f636b732c20636f6e74656e742074797065732c206d656e75732c206574632e223b7d7d, 'system', 0, 0, 1, 0, -8, 2, 0, 1, 21, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 22, 1, 'admin/tasks', 'admin/tasks', 'Tasks', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -20, 2, 0, 1, 22, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 23, 0, 'comment/reply/%', 'comment/reply/%', 'Add new comment', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 24, 3, 'comment/%/approve', 'comment/%/approve', 'Approve', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 1, 2, 0, 3, 24, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 25, 4, 'filter/tips/%', 'filter/tips/%', 'Compose tips', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 2, 0, 4, 25, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 26, 3, 'comment/%/delete', 'comment/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 2, 0, 3, 26, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 27, 3, 'comment/%/edit', 'comment/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 3, 27, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 28, 0, 'taxonomy/term/%', 'taxonomy/term/%', 'Taxonomy term', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 29, 3, 'comment/%/view', 'comment/%/view', 'View comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 3, 29, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 30, 18, 'admin/people/create', 'admin/people/create', 'Add user', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 18, 30, 0, 0, 0, 0, 0, 0, 0),
('management', 31, 21, 'admin/structure/block', 'admin/structure/block', 'Blocks', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37393a22436f6e666967757265207768617420626c6f636b20636f6e74656e74206170706561727320696e20796f75722073697465277320736964656261727320616e64206f7468657220726567696f6e732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 31, 0, 0, 0, 0, 0, 0, 0),
('navigation', 32, 17, 'user/%/cancel', 'user/%/cancel', 'Cancel account', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 2, 0, 17, 32, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 33, 9, 'admin/content/comment', 'admin/content/comment', 'Comments', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35393a224c69737420616e642065646974207369746520636f6d6d656e747320616e642074686520636f6d6d656e7420617070726f76616c2071756575652e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 9, 33, 0, 0, 0, 0, 0, 0, 0),
('management', 34, 11, 'admin/dashboard/configure', 'admin/dashboard/configure', 'Configure available dashboard blocks', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35333a22436f6e66696775726520776869636820626c6f636b732063616e2062652073686f776e206f6e207468652064617368626f6172642e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 11, 34, 0, 0, 0, 0, 0, 0, 0),
('management', 35, 9, 'admin/content/node', 'admin/content/node', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 3, 0, 1, 9, 35, 0, 0, 0, 0, 0, 0, 0),
('management', 36, 8, 'admin/config/content', 'admin/config/content', 'Content authoring', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35333a2253657474696e67732072656c6174656420746f20666f726d617474696e6720616e6420617574686f72696e6720636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, -15, 3, 0, 1, 8, 36, 0, 0, 0, 0, 0, 0, 0),
('management', 37, 21, 'admin/structure/types', 'admin/structure/types', 'Content types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a39323a224d616e61676520636f6e74656e742074797065732c20696e636c7564696e672064656661756c74207374617475732c2066726f6e7420706167652070726f6d6f74696f6e2c20636f6d6d656e742073657474696e67732c206574632e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 37, 0, 0, 0, 0, 0, 0, 0),
('management', 38, 11, 'admin/dashboard/customize', 'admin/dashboard/customize', 'Customize dashboard', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32353a22437573746f6d697a6520796f75722064617368626f6172642e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 11, 38, 0, 0, 0, 0, 0, 0, 0),
('navigation', 39, 5, 'node/%/delete', 'node/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 2, 0, 5, 39, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 40, 8, 'admin/config/development', 'admin/config/development', 'Development', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a22446576656c6f706d656e7420746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 40, 0, 0, 0, 0, 0, 0, 0),
('navigation', 41, 17, 'user/%/edit', 'user/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 17, 41, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 42, 5, 'node/%/edit', 'node/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 5, 42, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 43, 19, 'admin/reports/fields', 'admin/reports/fields', 'Field list', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a224f76657276696577206f66206669656c6473206f6e20616c6c20656e746974792074797065732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 43, 0, 0, 0, 0, 0, 0, 0),
('management', 44, 7, 'admin/appearance/list', 'admin/appearance/list', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33313a2253656c65637420616e6420636f6e66696775726520796f7572207468656d65223b7d7d, 'system', -1, 0, 0, 0, -1, 3, 0, 1, 7, 44, 0, 0, 0, 0, 0, 0, 0),
('management', 45, 16, 'admin/modules/list', 'admin/modules/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 16, 45, 0, 0, 0, 0, 0, 0, 0),
('management', 46, 18, 'admin/people/people', 'admin/people/people', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35303a2246696e6420616e64206d616e6167652070656f706c6520696e746572616374696e67207769746820796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, -10, 3, 0, 1, 18, 46, 0, 0, 0, 0, 0, 0, 0),
('management', 47, 8, 'admin/config/media', 'admin/config/media', 'Media', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31323a224d6564696120746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 47, 0, 0, 0, 0, 0, 0, 0),
('management', 48, 8, 'admin/config/people', 'admin/config/people', 'People', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32343a22436f6e6669677572652075736572206163636f756e74732e223b7d7d, 'system', 0, 0, 1, 0, -20, 3, 0, 1, 8, 48, 0, 0, 0, 0, 0, 0, 0),
('management', 49, 18, 'admin/people/permissions', 'admin/people/permissions', 'Permissions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2244657465726d696e652061636365737320746f2066656174757265732062792073656c656374696e67207065726d697373696f6e7320666f7220726f6c65732e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 18, 49, 0, 0, 0, 0, 0, 0, 0),
('management', 50, 19, 'admin/reports/dblog', 'admin/reports/dblog', 'Recent log messages', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a2256696577206576656e74732074686174206861766520726563656e746c79206265656e206c6f676765642e223b7d7d, 'system', 0, 0, 0, 0, -1, 3, 0, 1, 19, 50, 0, 0, 0, 0, 0, 0, 0),
('management', 51, 8, 'admin/config/regional', 'admin/config/regional', 'Regional and language', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a22526567696f6e616c2073657474696e67732c206c6f63616c697a6174696f6e20616e64207472616e736c6174696f6e2e223b7d7d, 'system', 0, 0, 1, 0, -5, 3, 0, 1, 8, 51, 0, 0, 0, 0, 0, 0, 0),
('navigation', 52, 5, 'node/%/revisions', 'node/%/revisions', 'Revisions', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 2, 2, 0, 5, 52, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 53, 8, 'admin/config/search', 'admin/config/search', 'Search and metadata', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a224c6f63616c2073697465207365617263682c206d6574616461746120616e642053454f2e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 53, 0, 0, 0, 0, 0, 0, 0),
('management', 54, 7, 'admin/appearance/settings', 'admin/appearance/settings', 'Settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a22436f6e6669677572652064656661756c7420616e64207468656d652073706563696669632073657474696e67732e223b7d7d, 'system', -1, 0, 0, 0, 20, 3, 0, 1, 7, 54, 0, 0, 0, 0, 0, 0, 0),
('management', 55, 19, 'admin/reports/status', 'admin/reports/status', 'Status report', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37343a22476574206120737461747573207265706f72742061626f757420796f757220736974652773206f7065726174696f6e20616e6420616e792064657465637465642070726f626c656d732e223b7d7d, 'system', 0, 0, 0, 0, -60, 3, 0, 1, 19, 55, 0, 0, 0, 0, 0, 0, 0),
('management', 56, 8, 'admin/config/system', 'admin/config/system', 'System', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33373a2247656e6572616c2073797374656d2072656c6174656420636f6e66696775726174696f6e2e223b7d7d, 'system', 0, 0, 1, 0, -20, 3, 0, 1, 8, 56, 0, 0, 0, 0, 0, 0, 0),
('management', 57, 21, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Taxonomy', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36373a224d616e6167652074616767696e672c2063617465676f72697a6174696f6e2c20616e6420636c617373696669636174696f6e206f6620796f757220636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 57, 0, 0, 0, 0, 0, 0, 0),
('management', 58, 19, 'admin/reports/access-denied', 'admin/reports/access-denied', 'Top \'access denied\' errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33353a225669657720276163636573732064656e69656427206572726f7273202834303373292e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 58, 0, 0, 0, 0, 0, 0, 0),
('management', 59, 19, 'admin/reports/page-not-found', 'admin/reports/page-not-found', 'Top \'page not found\' errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a2256696577202770616765206e6f7420666f756e6427206572726f7273202834303473292e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 59, 0, 0, 0, 0, 0, 0, 0),
('management', 60, 16, 'admin/modules/uninstall', 'admin/modules/uninstall', 'Uninstall', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 20, 3, 0, 1, 16, 60, 0, 0, 0, 0, 0, 0, 0),
('management', 61, 8, 'admin/config/user-interface', 'admin/config/user-interface', 'User interface', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33383a22546f6f6c73207468617420656e68616e636520746865207573657220696e746572666163652e223b7d7d, 'system', 0, 0, 1, 0, -15, 3, 0, 1, 8, 61, 0, 0, 0, 0, 0, 0, 0),
('navigation', 62, 5, 'node/%/view', 'node/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 5, 62, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 63, 17, 'user/%/view', 'user/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 17, 63, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 64, 8, 'admin/config/services', 'admin/config/services', 'Web services', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a22546f6f6c732072656c6174656420746f207765622073657276696365732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 8, 64, 0, 0, 0, 0, 0, 0, 0),
('management', 65, 8, 'admin/config/workflow', 'admin/config/workflow', 'Workflow', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22436f6e74656e7420776f726b666c6f772c20656469746f7269616c20776f726b666c6f7720746f6f6c732e223b7d7d, 'system', 0, 0, 0, 0, 5, 3, 0, 1, 8, 65, 0, 0, 0, 0, 0, 0, 0),
('management', 66, 12, 'admin/help/block', 'admin/help/block', 'block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 66, 0, 0, 0, 0, 0, 0, 0),
('management', 67, 12, 'admin/help/color', 'admin/help/color', 'color', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 67, 0, 0, 0, 0, 0, 0, 0),
('management', 68, 12, 'admin/help/comment', 'admin/help/comment', 'comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 68, 0, 0, 0, 0, 0, 0, 0),
('management', 69, 12, 'admin/help/contextual', 'admin/help/contextual', 'contextual', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 69, 0, 0, 0, 0, 0, 0, 0),
('management', 70, 12, 'admin/help/dashboard', 'admin/help/dashboard', 'dashboard', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 70, 0, 0, 0, 0, 0, 0, 0),
('management', 71, 12, 'admin/help/dblog', 'admin/help/dblog', 'dblog', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 71, 0, 0, 0, 0, 0, 0, 0),
('management', 72, 12, 'admin/help/field', 'admin/help/field', 'field', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 72, 0, 0, 0, 0, 0, 0, 0),
('management', 73, 12, 'admin/help/field_sql_storage', 'admin/help/field_sql_storage', 'field_sql_storage', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 73, 0, 0, 0, 0, 0, 0, 0),
('management', 74, 12, 'admin/help/field_ui', 'admin/help/field_ui', 'field_ui', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 74, 0, 0, 0, 0, 0, 0, 0),
('management', 75, 12, 'admin/help/file', 'admin/help/file', 'file', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 75, 0, 0, 0, 0, 0, 0, 0),
('management', 76, 12, 'admin/help/filter', 'admin/help/filter', 'filter', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 76, 0, 0, 0, 0, 0, 0, 0),
('management', 77, 12, 'admin/help/help', 'admin/help/help', 'help', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 77, 0, 0, 0, 0, 0, 0, 0),
('management', 78, 12, 'admin/help/image', 'admin/help/image', 'image', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 78, 0, 0, 0, 0, 0, 0, 0),
('management', 79, 12, 'admin/help/list', 'admin/help/list', 'list', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 79, 0, 0, 0, 0, 0, 0, 0),
('management', 80, 12, 'admin/help/node', 'admin/help/node', 'node', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 80, 0, 0, 0, 0, 0, 0, 0),
('management', 81, 12, 'admin/help/options', 'admin/help/options', 'options', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 81, 0, 0, 0, 0, 0, 0, 0),
('management', 82, 12, 'admin/help/system', 'admin/help/system', 'system', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 82, 0, 0, 0, 0, 0, 0, 0),
('management', 83, 12, 'admin/help/taxonomy', 'admin/help/taxonomy', 'taxonomy', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 83, 0, 0, 0, 0, 0, 0, 0),
('management', 84, 12, 'admin/help/text', 'admin/help/text', 'text', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 84, 0, 0, 0, 0, 0, 0, 0),
('management', 85, 12, 'admin/help/user', 'admin/help/user', 'user', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 85, 0, 0, 0, 0, 0, 0, 0),
('navigation', 86, 28, 'taxonomy/term/%/edit', 'taxonomy/term/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 2, 0, 28, 86, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 87, 28, 'taxonomy/term/%/view', 'taxonomy/term/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 28, 87, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 88, 57, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 57, 88, 0, 0, 0, 0, 0, 0),
('management', 89, 48, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Account settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130393a22436f6e6669677572652064656661756c74206265686176696f72206f662075736572732c20696e636c7564696e6720726567697374726174696f6e20726571756972656d656e74732c20652d6d61696c732c206669656c64732c20616e6420757365722070696374757265732e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 48, 89, 0, 0, 0, 0, 0, 0),
('management', 90, 56, 'admin/config/system/actions', 'admin/config/system/actions', 'Actions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a224d616e6167652074686520616374696f6e7320646566696e656420666f7220796f757220736974652e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 56, 90, 0, 0, 0, 0, 0, 0),
('management', 91, 31, 'admin/structure/block/add', 'admin/structure/block/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 91, 0, 0, 0, 0, 0, 0),
('management', 92, 37, 'admin/structure/types/add', 'admin/structure/types/add', 'Add content type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 37, 92, 0, 0, 0, 0, 0, 0),
('management', 93, 57, 'admin/structure/taxonomy/add', 'admin/structure/taxonomy/add', 'Add vocabulary', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 57, 93, 0, 0, 0, 0, 0, 0),
('management', 94, 54, 'admin/appearance/settings/bartik', 'admin/appearance/settings/bartik', 'Bartik', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 94, 0, 0, 0, 0, 0, 0),
('management', 95, 53, 'admin/config/search/clean-urls', 'admin/config/search/clean-urls', 'Clean URLs', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22456e61626c65206f722064697361626c6520636c65616e2055524c7320666f7220796f757220736974652e223b7d7d, 'system', 0, 0, 0, 0, 5, 4, 0, 1, 8, 53, 95, 0, 0, 0, 0, 0, 0),
('management', 96, 56, 'admin/config/system/cron', 'admin/config/system/cron', 'Cron', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34303a224d616e616765206175746f6d617469632073697465206d61696e74656e616e6365207461736b732e223b7d7d, 'system', 0, 0, 0, 0, 20, 4, 0, 1, 8, 56, 96, 0, 0, 0, 0, 0, 0),
('management', 97, 51, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Date and time', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34343a22436f6e66696775726520646973706c617920666f726d61747320666f72206461746520616e642074696d652e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 51, 97, 0, 0, 0, 0, 0, 0),
('management', 98, 19, 'admin/reports/event/%', 'admin/reports/event/%', 'Details', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 98, 0, 0, 0, 0, 0, 0, 0),
('management', 99, 47, 'admin/config/media/file-system', 'admin/config/media/file-system', 'File system', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36383a2254656c6c2044727570616c20776865726520746f2073746f72652075706c6f616465642066696c657320616e6420686f772074686579206172652061636365737365642e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 47, 99, 0, 0, 0, 0, 0, 0),
('management', 100, 54, 'admin/appearance/settings/garland', 'admin/appearance/settings/garland', 'Garland', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 100, 0, 0, 0, 0, 0, 0),
('management', 101, 54, 'admin/appearance/settings/global', 'admin/appearance/settings/global', 'Global settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -1, 4, 0, 1, 7, 54, 101, 0, 0, 0, 0, 0, 0),
('management', 102, 48, 'admin/config/people/ip-blocking', 'admin/config/people/ip-blocking', 'IP address blocking', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a224d616e61676520626c6f636b6564204950206164647265737365732e223b7d7d, 'system', 0, 0, 1, 0, 10, 4, 0, 1, 8, 48, 102, 0, 0, 0, 0, 0, 0),
('management', 103, 47, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Image styles', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37383a22436f6e666967757265207374796c657320746861742063616e206265207573656420666f7220726573697a696e67206f722061646a757374696e6720696d61676573206f6e20646973706c61792e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 47, 103, 0, 0, 0, 0, 0, 0),
('management', 104, 47, 'admin/config/media/image-toolkit', 'admin/config/media/image-toolkit', 'Image toolkit', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37343a2243686f6f736520776869636820696d61676520746f6f6c6b697420746f2075736520696620796f75206861766520696e7374616c6c6564206f7074696f6e616c20746f6f6c6b6974732e223b7d7d, 'system', 0, 0, 0, 0, 20, 4, 0, 1, 8, 47, 104, 0, 0, 0, 0, 0, 0),
('management', 105, 45, 'admin/modules/list/confirm', 'admin/modules/list/confirm', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 16, 45, 105, 0, 0, 0, 0, 0, 0),
('management', 106, 37, 'admin/structure/types/list', 'admin/structure/types/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 37, 106, 0, 0, 0, 0, 0, 0),
('management', 107, 57, 'admin/structure/taxonomy/list', 'admin/structure/taxonomy/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 57, 107, 0, 0, 0, 0, 0, 0),
('management', 108, 40, 'admin/config/development/logging', 'admin/config/development/logging', 'Logging and errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3135343a2253657474696e677320666f72206c6f6767696e6720616e6420616c65727473206d6f64756c65732e20566172696f7573206d6f64756c65732063616e20726f7574652044727570616c27732073797374656d206576656e747320746f20646966666572656e742064657374696e6174696f6e732c2073756368206173207379736c6f672c2064617461626173652c20656d61696c2c206574632e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 40, 108, 0, 0, 0, 0, 0, 0),
('management', 109, 40, 'admin/config/development/maintenance', 'admin/config/development/maintenance', 'Maintenance mode', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36323a2254616b65207468652073697465206f66666c696e6520666f72206d61696e74656e616e6365206f72206272696e67206974206261636b206f6e6c696e652e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 40, 109, 0, 0, 0, 0, 0, 0),
('management', 110, 40, 'admin/config/development/performance', 'admin/config/development/performance', 'Performance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130313a22456e61626c65206f722064697361626c6520706167652063616368696e6720666f7220616e6f6e796d6f757320757365727320616e64207365742043535320616e64204a532062616e647769647468206f7074696d697a6174696f6e206f7074696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 40, 110, 0, 0, 0, 0, 0, 0),
('management', 111, 49, 'admin/people/permissions/list', 'admin/people/permissions/list', 'Permissions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2244657465726d696e652061636365737320746f2066656174757265732062792073656c656374696e67207065726d697373696f6e7320666f7220726f6c65732e223b7d7d, 'system', -1, 0, 0, 0, -8, 4, 0, 1, 18, 49, 111, 0, 0, 0, 0, 0, 0),
('management', 112, 33, 'admin/content/comment/new', 'admin/content/comment/new', 'Published comments', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 9, 33, 112, 0, 0, 0, 0, 0, 0),
('management', 113, 64, 'admin/config/services/rss-publishing', 'admin/config/services/rss-publishing', 'RSS publishing', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3131343a22436f6e666967757265207468652073697465206465736372697074696f6e2c20746865206e756d626572206f66206974656d7320706572206665656420616e6420776865746865722066656564732073686f756c64206265207469746c65732f746561736572732f66756c6c2d746578742e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 64, 113, 0, 0, 0, 0, 0, 0),
('management', 114, 51, 'admin/config/regional/settings', 'admin/config/regional/settings', 'Regional settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35343a2253657474696e677320666f7220746865207369746527732064656661756c742074696d65207a6f6e6520616e6420636f756e7472792e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 51, 114, 0, 0, 0, 0, 0, 0),
('management', 115, 49, 'admin/people/permissions/roles', 'admin/people/permissions/roles', 'Roles', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a224c6973742c20656469742c206f7220616464207573657220726f6c65732e223b7d7d, 'system', -1, 0, 1, 0, -5, 4, 0, 1, 18, 49, 115, 0, 0, 0, 0, 0, 0),
('management', 116, 54, 'admin/appearance/settings/seven', 'admin/appearance/settings/seven', 'Seven', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 116, 0, 0, 0, 0, 0, 0),
('management', 117, 56, 'admin/config/system/site-information', 'admin/config/system/site-information', 'Site information', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130343a224368616e67652073697465206e616d652c20652d6d61696c20616464726573732c20736c6f67616e2c2064656661756c742066726f6e7420706167652c20616e64206e756d626572206f6620706f7374732070657220706167652c206572726f722070616765732e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 56, 117, 0, 0, 0, 0, 0, 0),
('management', 118, 54, 'admin/appearance/settings/stark', 'admin/appearance/settings/stark', 'Stark', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 118, 0, 0, 0, 0, 0, 0),
('management', 119, 36, 'admin/config/content/formats', 'admin/config/content/formats', 'Text formats', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3132373a22436f6e66696775726520686f7720636f6e74656e7420696e7075742062792075736572732069732066696c74657265642c20696e636c7564696e6720616c6c6f7765642048544d4c20746167732e20416c736f20616c6c6f777320656e61626c696e67206f66206d6f64756c652d70726f76696465642066696c746572732e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 36, 119, 0, 0, 0, 0, 0, 0),
('management', 120, 33, 'admin/content/comment/approval', 'admin/content/comment/approval', 'Unapproved comments', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 9, 33, 120, 0, 0, 0, 0, 0, 0),
('management', 121, 60, 'admin/modules/uninstall/confirm', 'admin/modules/uninstall/confirm', 'Uninstall', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 16, 60, 121, 0, 0, 0, 0, 0, 0),
('navigation', 122, 41, 'user/%/edit/account', 'user/%/edit/account', 'Account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 17, 41, 122, 0, 0, 0, 0, 0, 0, 0),
('management', 123, 119, 'admin/config/content/formats/%', 'admin/config/content/formats/%', '', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 36, 119, 123, 0, 0, 0, 0, 0),
('management', 124, 103, 'admin/config/media/image-styles/add', 'admin/config/media/image-styles/add', 'Add style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a224164642061206e657720696d616765207374796c652e223b7d7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 47, 103, 124, 0, 0, 0, 0, 0),
('management', 125, 88, 'admin/structure/taxonomy/%/add', 'admin/structure/taxonomy/%/add', 'Add term', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 57, 88, 125, 0, 0, 0, 0, 0),
('management', 126, 119, 'admin/config/content/formats/add', 'admin/config/content/formats/add', 'Add text format', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 8, 36, 119, 126, 0, 0, 0, 0, 0),
('management', 127, 31, 'admin/structure/block/list/bartik', 'admin/structure/block/list/bartik', 'Bartik', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 127, 0, 0, 0, 0, 0, 0),
('management', 128, 90, 'admin/config/system/actions/configure', 'admin/config/system/actions/configure', 'Configure an advanced action', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 56, 90, 128, 0, 0, 0, 0, 0),
('management', 129, 88, 'admin/structure/taxonomy/%/edit', 'admin/structure/taxonomy/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 57, 88, 129, 0, 0, 0, 0, 0),
('management', 130, 37, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit content type', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 21, 37, 130, 0, 0, 0, 0, 0, 0),
('management', 131, 97, 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time/formats', 'Formats', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35313a22436f6e66696775726520646973706c617920666f726d617420737472696e677320666f72206461746520616e642074696d652e223b7d7d, 'system', -1, 0, 1, 0, -9, 5, 0, 1, 8, 51, 97, 131, 0, 0, 0, 0, 0),
('management', 132, 31, 'admin/structure/block/list/garland', 'admin/structure/block/list/garland', 'Garland', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 132, 0, 0, 0, 0, 0, 0),
('management', 133, 88, 'admin/structure/taxonomy/%/list', 'admin/structure/taxonomy/%/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -20, 5, 0, 1, 21, 57, 88, 133, 0, 0, 0, 0, 0),
('management', 134, 119, 'admin/config/content/formats/list', 'admin/config/content/formats/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 36, 119, 134, 0, 0, 0, 0, 0),
('management', 135, 103, 'admin/config/media/image-styles/list', 'admin/config/media/image-styles/list', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34323a224c697374207468652063757272656e7420696d616765207374796c6573206f6e2074686520736974652e223b7d7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 8, 47, 103, 135, 0, 0, 0, 0, 0),
('management', 136, 90, 'admin/config/system/actions/manage', 'admin/config/system/actions/manage', 'Manage actions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a224d616e6167652074686520616374696f6e7320646566696e656420666f7220796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, -2, 5, 0, 1, 8, 56, 90, 136, 0, 0, 0, 0, 0),
('management', 139, 89, 'admin/config/people/accounts/settings', 'admin/config/people/accounts/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 8, 48, 89, 139, 0, 0, 0, 0, 0),
('management', 140, 31, 'admin/structure/block/list/seven', 'admin/structure/block/list/seven', 'Seven', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 31, 140, 0, 0, 0, 0, 0, 0),
('management', 141, 31, 'admin/structure/block/list/stark', 'admin/structure/block/list/stark', 'Stark', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 141, 0, 0, 0, 0, 0, 0),
('management', 142, 97, 'admin/config/regional/date-time/types', 'admin/config/regional/date-time/types', 'Types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34343a22436f6e66696775726520646973706c617920666f726d61747320666f72206461746520616e642074696d652e223b7d7d, 'system', -1, 0, 1, 0, -10, 5, 0, 1, 8, 51, 97, 142, 0, 0, 0, 0, 0),
('navigation', 143, 52, 'node/%/revisions/%/delete', 'node/%/revisions/%/delete', 'Delete earlier revision', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 52, 143, 0, 0, 0, 0, 0, 0, 0),
('navigation', 144, 52, 'node/%/revisions/%/revert', 'node/%/revisions/%/revert', 'Revert to earlier revision', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 52, 144, 0, 0, 0, 0, 0, 0, 0),
('navigation', 145, 52, 'node/%/revisions/%/view', 'node/%/revisions/%/view', 'Revisions', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 52, 145, 0, 0, 0, 0, 0, 0, 0),
('management', 146, 132, 'admin/structure/block/list/garland/add', 'admin/structure/block/list/garland/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 132, 146, 0, 0, 0, 0, 0),
('management', 148, 141, 'admin/structure/block/list/stark/add', 'admin/structure/block/list/stark/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 141, 148, 0, 0, 0, 0, 0),
('management', 149, 142, 'admin/config/regional/date-time/types/add', 'admin/config/regional/date-time/types/add', 'Add date type', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a22416464206e6577206461746520747970652e223b7d7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 51, 97, 142, 149, 0, 0, 0, 0),
('management', 150, 131, 'admin/config/regional/date-time/formats/add', 'admin/config/regional/date-time/formats/add', 'Add format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22416c6c6f7720757365727320746f20616464206164646974696f6e616c206461746520666f726d6174732e223b7d7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 51, 97, 131, 150, 0, 0, 0, 0),
('management', 151, 31, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 31, 151, 0, 0, 0, 0, 0, 0),
('navigation', 152, 32, 'user/%/cancel/confirm/%/%', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 17, 32, 152, 0, 0, 0, 0, 0, 0, 0),
('management', 154, 130, 'admin/structure/types/manage/%/delete', 'admin/structure/types/manage/%/delete', 'Delete', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 21, 37, 130, 154, 0, 0, 0, 0, 0),
('management', 155, 102, 'admin/config/people/ip-blocking/delete/%', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 48, 102, 155, 0, 0, 0, 0, 0),
('management', 156, 90, 'admin/config/system/actions/delete/%', 'admin/config/system/actions/delete/%', 'Delete action', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31373a2244656c65746520616e20616374696f6e2e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 56, 90, 156, 0, 0, 0, 0, 0),
('management', 157, 115, 'admin/people/permissions/roles/delete/%', 'admin/people/permissions/roles/delete/%', 'Delete role', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 18, 49, 115, 157, 0, 0, 0, 0, 0),
('management', 158, 123, 'admin/config/content/formats/%/disable', 'admin/config/content/formats/%/disable', 'Disable text format', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 36, 119, 123, 158, 0, 0, 0, 0),
('management', 159, 130, 'admin/structure/types/manage/%/edit', 'admin/structure/types/manage/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 37, 130, 159, 0, 0, 0, 0, 0),
('management', 160, 115, 'admin/people/permissions/roles/edit/%', 'admin/people/permissions/roles/edit/%', 'Edit role', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 18, 49, 115, 160, 0, 0, 0, 0, 0),
('management', 161, 103, 'admin/config/media/image-styles/edit/%', 'admin/config/media/image-styles/edit/%', 'Edit style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32353a22436f6e66696775726520616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 47, 103, 161, 0, 0, 0, 0, 0),
('management', 163, 103, 'admin/config/media/image-styles/delete/%', 'admin/config/media/image-styles/delete/%', 'Delete style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a2244656c65746520616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 47, 103, 163, 0, 0, 0, 0, 0),
('management', 165, 103, 'admin/config/media/image-styles/revert/%', 'admin/config/media/image-styles/revert/%', 'Revert style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a2252657665727420616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 47, 103, 165, 0, 0, 0, 0, 0),
('management', 166, 130, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%/comment/display', 'Comment display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 5, 0, 1, 21, 37, 130, 166, 0, 0, 0, 0, 0),
('management', 167, 130, 'admin/structure/types/manage/%/comment/fields', 'admin/structure/types/manage/%/comment/fields', 'Comment fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 3, 5, 0, 1, 21, 37, 130, 167, 0, 0, 0, 0, 0),
('management', 168, 151, 'admin/structure/block/manage/%/%/configure', 'admin/structure/block/manage/%/%/configure', 'Configure block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 151, 168, 0, 0, 0, 0, 0),
('management', 169, 151, 'admin/structure/block/manage/%/%/delete', 'admin/structure/block/manage/%/%/delete', 'Delete block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 151, 169, 0, 0, 0, 0, 0),
('management', 170, 131, 'admin/config/regional/date-time/formats/%/delete', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34373a22416c6c6f7720757365727320746f2064656c657465206120636f6e66696775726564206461746520666f726d61742e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 51, 97, 131, 170, 0, 0, 0, 0),
('management', 171, 142, 'admin/config/regional/date-time/types/%/delete', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a22416c6c6f7720757365727320746f2064656c657465206120636f6e66696775726564206461746520747970652e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 51, 97, 142, 171, 0, 0, 0, 0),
('management', 172, 131, 'admin/config/regional/date-time/formats/%/edit', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a22416c6c6f7720757365727320746f2065646974206120636f6e66696775726564206461746520666f726d61742e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 51, 97, 131, 172, 0, 0, 0, 0),
('management', 177, 161, 'admin/config/media/image-styles/edit/%/add/%', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a224164642061206e65772065666665637420746f2061207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 47, 103, 161, 177, 0, 0, 0, 0),
('management', 178, 161, 'admin/config/media/image-styles/edit/%/effects/%', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a224564697420616e206578697374696e67206566666563742077697468696e2061207374796c652e223b7d7d, 'system', 0, 0, 1, 0, 0, 6, 0, 1, 8, 47, 103, 161, 178, 0, 0, 0, 0),
('management', 179, 178, 'admin/config/media/image-styles/edit/%/effects/%/delete', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a2244656c65746520616e206578697374696e67206566666563742066726f6d2061207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 7, 0, 1, 8, 47, 103, 161, 178, 179, 0, 0, 0),
('management', 202, 19, 'admin/reports/search', 'admin/reports/search', 'Top search phrases', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33333a2256696577206d6f737420706f70756c61722073656172636820706872617365732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 202, 0, 0, 0, 0, 0, 0, 0),
('shortcut-set-1', 226, 0, 'node/add', 'node/add', 'Add content', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -20, 1, 0, 226, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('shortcut-set-1', 227, 0, 'admin/content', 'admin/content', 'Find content', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -19, 1, 0, 227, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 228, 0, '<front>', '', 'Home', 0x613a303a7b7d, 'menu', 0, 1, 0, 0, 0, 1, 0, 228, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 229, 6, 'node/add/article', 'node/add/article', 'Article', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38393a22557365203c656d3e61727469636c65733c2f656d3e20666f722074696d652d73656e73697469766520636f6e74656e74206c696b65206e6577732c2070726573732072656c6561736573206f7220626c6f6720706f7374732e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 229, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 230, 6, 'node/add/page', 'node/add/page', 'Basic page', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37373a22557365203c656d3e62617369632070616765733c2f656d3e20666f7220796f75722073746174696320636f6e74656e742c207375636820617320616e202741626f75742075732720706167652e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 230, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 269, 0, 'search', 'search', 'Search', 0x613a303a7b7d, 'system', 1, 0, 0, 0, 0, 1, 0, 269, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 270, 269, 'search/node', 'search/node', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 269, 270, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 271, 269, 'search/user', 'search/user', 'Users', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 269, 271, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 272, 270, 'search/node/%', 'search/node/%', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 269, 270, 272, 0, 0, 0, 0, 0, 0, 0),
('management', 273, 21, 'admin/structure/menu', 'admin/structure/menu', 'Menus', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38363a22416464206e6577206d656e757320746f20796f757220736974652c2065646974206578697374696e67206d656e75732c20616e642072656e616d6520616e642072656f7267616e697a65206d656e75206c696e6b732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 273, 0, 0, 0, 0, 0, 0, 0),
('navigation', 274, 17, 'user/%/shortcuts', 'user/%/shortcuts', 'Shortcuts', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 17, 274, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 275, 271, 'search/user/%', 'search/user/%', 'Users', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 269, 271, 275, 0, 0, 0, 0, 0, 0, 0),
('management', 276, 12, 'admin/help/menu', 'admin/help/menu', 'menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 276, 0, 0, 0, 0, 0, 0, 0),
('management', 277, 12, 'admin/help/number', 'admin/help/number', 'number', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 277, 0, 0, 0, 0, 0, 0, 0),
('management', 279, 12, 'admin/help/path', 'admin/help/path', 'path', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 279, 0, 0, 0, 0, 0, 0, 0),
('management', 280, 12, 'admin/help/rdf', 'admin/help/rdf', 'rdf', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 280, 0, 0, 0, 0, 0, 0, 0),
('management', 281, 12, 'admin/help/search', 'admin/help/search', 'search', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 281, 0, 0, 0, 0, 0, 0, 0),
('management', 282, 12, 'admin/help/shortcut', 'admin/help/shortcut', 'shortcut', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 282, 0, 0, 0, 0, 0, 0, 0),
('management', 284, 273, 'admin/structure/menu/add', 'admin/structure/menu/add', 'Add menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 273, 284, 0, 0, 0, 0, 0, 0),
('management', 285, 273, 'admin/structure/menu/list', 'admin/structure/menu/list', 'List menus', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 273, 285, 0, 0, 0, 0, 0, 0),
('management', 286, 53, 'admin/config/search/settings', 'admin/config/search/settings', 'Search settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36373a22436f6e6669677572652072656c6576616e63652073657474696e677320666f722073656172636820616e64206f7468657220696e646578696e67206f7074696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 53, 286, 0, 0, 0, 0, 0, 0),
('management', 287, 273, 'admin/structure/menu/settings', 'admin/structure/menu/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 5, 4, 0, 1, 21, 273, 287, 0, 0, 0, 0, 0, 0),
('management', 288, 61, 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Shortcuts', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32393a2241646420616e64206d6f646966792073686f727463757420736574732e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 61, 288, 0, 0, 0, 0, 0, 0),
('management', 289, 53, 'admin/config/search/path', 'admin/config/search/path', 'URL aliases', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a224368616e676520796f7572207369746527732055524c20706174687320627920616c696173696e67207468656d2e223b7d7d, 'system', 0, 0, 1, 0, -5, 4, 0, 1, 8, 53, 289, 0, 0, 0, 0, 0, 0),
('management', 290, 289, 'admin/config/search/path/add', 'admin/config/search/path/add', 'Add alias', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 53, 289, 290, 0, 0, 0, 0, 0),
('management', 291, 288, 'admin/config/user-interface/shortcut/add-set', 'admin/config/user-interface/shortcut/add-set', 'Add shortcut set', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 61, 288, 291, 0, 0, 0, 0, 0),
('management', 292, 286, 'admin/config/search/settings/reindex', 'admin/config/search/settings/reindex', 'Clear index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 53, 286, 292, 0, 0, 0, 0, 0),
('management', 293, 273, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Customize menu', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 21, 273, 293, 0, 0, 0, 0, 0, 0),
('management', 294, 288, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 61, 288, 294, 0, 0, 0, 0, 0),
('management', 295, 289, 'admin/config/search/path/list', 'admin/config/search/path/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 8, 53, 289, 295, 0, 0, 0, 0, 0),
('management', 296, 293, 'admin/structure/menu/manage/%/add', 'admin/structure/menu/manage/%/add', 'Add link', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 273, 293, 296, 0, 0, 0, 0, 0),
('management', 297, 294, 'admin/config/user-interface/shortcut/%/add-link', 'admin/config/user-interface/shortcut/%/add-link', 'Add shortcut', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 61, 288, 294, 297, 0, 0, 0, 0),
('management', 298, 289, 'admin/config/search/path/delete/%', 'admin/config/search/path/delete/%', 'Delete alias', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 53, 289, 298, 0, 0, 0, 0, 0);
INSERT INTO `menu_links` (`menu_name`, `mlid`, `plid`, `link_path`, `router_path`, `link_title`, `options`, `module`, `hidden`, `external`, `has_children`, `expanded`, `weight`, `depth`, `customized`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `updated`) VALUES
('management', 299, 293, 'admin/structure/menu/manage/%/delete', 'admin/structure/menu/manage/%/delete', 'Delete menu', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 21, 273, 293, 299, 0, 0, 0, 0, 0),
('management', 300, 273, 'admin/structure/menu/item/%/delete', 'admin/structure/menu/item/%/delete', 'Delete menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 273, 300, 0, 0, 0, 0, 0, 0),
('management', 301, 294, 'admin/config/user-interface/shortcut/%/delete', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 61, 288, 294, 301, 0, 0, 0, 0),
('management', 302, 289, 'admin/config/search/path/edit/%', 'admin/config/search/path/edit/%', 'Edit alias', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 53, 289, 302, 0, 0, 0, 0, 0),
('management', 303, 293, 'admin/structure/menu/manage/%/edit', 'admin/structure/menu/manage/%/edit', 'Edit menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 273, 293, 303, 0, 0, 0, 0, 0),
('management', 304, 273, 'admin/structure/menu/item/%/edit', 'admin/structure/menu/item/%/edit', 'Edit menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 273, 304, 0, 0, 0, 0, 0, 0),
('management', 305, 294, 'admin/config/user-interface/shortcut/%/edit', 'admin/config/user-interface/shortcut/%/edit', 'Edit set name', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 6, 0, 1, 8, 61, 288, 294, 305, 0, 0, 0, 0),
('management', 306, 288, 'admin/config/user-interface/shortcut/link/%', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 61, 288, 306, 0, 0, 0, 0, 0),
('management', 307, 293, 'admin/structure/menu/manage/%/list', 'admin/structure/menu/manage/%/list', 'List links', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 273, 293, 307, 0, 0, 0, 0, 0),
('management', 308, 294, 'admin/config/user-interface/shortcut/%/links', 'admin/config/user-interface/shortcut/%/links', 'List links', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 61, 288, 294, 308, 0, 0, 0, 0),
('management', 309, 273, 'admin/structure/menu/item/%/reset', 'admin/structure/menu/item/%/reset', 'Reset menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 273, 309, 0, 0, 0, 0, 0, 0),
('management', 310, 306, 'admin/config/user-interface/shortcut/link/%/delete', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 61, 288, 306, 310, 0, 0, 0, 0),
('management', 311, 19, 'admin/reports/updates', 'admin/reports/updates', 'Available updates', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38323a22476574206120737461747573207265706f72742061626f757420617661696c61626c65207570646174657320666f7220796f757220696e7374616c6c6564206d6f64756c657320616e64207468656d65732e223b7d7d, 'system', 0, 0, 0, 0, -50, 3, 0, 1, 19, 311, 0, 0, 0, 0, 0, 0, 0),
('management', 312, 7, 'admin/appearance/install', 'admin/appearance/install', 'Install new theme', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 3, 0, 1, 7, 312, 0, 0, 0, 0, 0, 0, 0),
('management', 313, 16, 'admin/modules/install', 'admin/modules/install', 'Install new module', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 3, 0, 1, 16, 313, 0, 0, 0, 0, 0, 0, 0),
('management', 314, 16, 'admin/modules/update', 'admin/modules/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 3, 0, 1, 16, 314, 0, 0, 0, 0, 0, 0, 0),
('management', 315, 7, 'admin/appearance/update', 'admin/appearance/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 3, 0, 1, 7, 315, 0, 0, 0, 0, 0, 0, 0),
('management', 316, 12, 'admin/help/update', 'admin/help/update', 'update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 316, 0, 0, 0, 0, 0, 0, 0),
('management', 317, 311, 'admin/reports/updates/install', 'admin/reports/updates/install', 'Install new module or theme', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 4, 0, 1, 19, 311, 317, 0, 0, 0, 0, 0, 0),
('management', 318, 311, 'admin/reports/updates/update', 'admin/reports/updates/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 4, 0, 1, 19, 311, 318, 0, 0, 0, 0, 0, 0),
('management', 319, 311, 'admin/reports/updates/list', 'admin/reports/updates/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 19, 311, 319, 0, 0, 0, 0, 0, 0),
('management', 320, 311, 'admin/reports/updates/settings', 'admin/reports/updates/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 50, 4, 0, 1, 19, 311, 320, 0, 0, 0, 0, 0, 0),
('management', 321, 88, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 21, 57, 88, 321, 0, 0, 0, 0, 0),
('management', 322, 89, 'admin/config/people/accounts/display', 'admin/config/people/accounts/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 48, 89, 322, 0, 0, 0, 0, 0),
('management', 323, 88, 'admin/structure/taxonomy/%/fields', 'admin/structure/taxonomy/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 21, 57, 88, 323, 0, 0, 0, 0, 0),
('management', 324, 89, 'admin/config/people/accounts/fields', 'admin/config/people/accounts/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 8, 48, 89, 324, 0, 0, 0, 0, 0),
('management', 325, 321, 'admin/structure/taxonomy/%/display/default', 'admin/structure/taxonomy/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 57, 88, 321, 325, 0, 0, 0, 0),
('management', 326, 322, 'admin/config/people/accounts/display/default', 'admin/config/people/accounts/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 48, 89, 322, 326, 0, 0, 0, 0),
('management', 327, 130, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 21, 37, 130, 327, 0, 0, 0, 0, 0),
('management', 328, 130, 'admin/structure/types/manage/%/fields', 'admin/structure/types/manage/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 21, 37, 130, 328, 0, 0, 0, 0, 0),
('management', 329, 321, 'admin/structure/taxonomy/%/display/full', 'admin/structure/taxonomy/%/display/full', 'Taxonomy term page', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 57, 88, 321, 329, 0, 0, 0, 0),
('management', 330, 322, 'admin/config/people/accounts/display/full', 'admin/config/people/accounts/display/full', 'User account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 48, 89, 322, 330, 0, 0, 0, 0),
('management', 331, 323, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 57, 88, 323, 331, 0, 0, 0, 0),
('management', 332, 324, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 48, 89, 324, 332, 0, 0, 0, 0),
('management', 333, 327, 'admin/structure/types/manage/%/display/default', 'admin/structure/types/manage/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 37, 130, 327, 333, 0, 0, 0, 0),
('management', 334, 327, 'admin/structure/types/manage/%/display/full', 'admin/structure/types/manage/%/display/full', 'Full content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 37, 130, 327, 334, 0, 0, 0, 0),
('management', 335, 327, 'admin/structure/types/manage/%/display/rss', 'admin/structure/types/manage/%/display/rss', 'RSS', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 6, 0, 1, 21, 37, 130, 327, 335, 0, 0, 0, 0),
('management', 336, 327, 'admin/structure/types/manage/%/display/search_index', 'admin/structure/types/manage/%/display/search_index', 'Search index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 3, 6, 0, 1, 21, 37, 130, 327, 336, 0, 0, 0, 0),
('management', 337, 327, 'admin/structure/types/manage/%/display/search_result', 'admin/structure/types/manage/%/display/search_result', 'Search result highlighting input', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 6, 0, 1, 21, 37, 130, 327, 337, 0, 0, 0, 0),
('management', 338, 327, 'admin/structure/types/manage/%/display/teaser', 'admin/structure/types/manage/%/display/teaser', 'Teaser', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 6, 0, 1, 21, 37, 130, 327, 338, 0, 0, 0, 0),
('management', 339, 328, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 37, 130, 328, 339, 0, 0, 0, 0),
('management', 340, 331, 'admin/structure/taxonomy/%/fields/%/delete', 'admin/structure/taxonomy/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 57, 88, 323, 331, 340, 0, 0, 0),
('management', 341, 331, 'admin/structure/taxonomy/%/fields/%/edit', 'admin/structure/taxonomy/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 57, 88, 323, 331, 341, 0, 0, 0),
('management', 342, 331, 'admin/structure/taxonomy/%/fields/%/field-settings', 'admin/structure/taxonomy/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 57, 88, 323, 331, 342, 0, 0, 0),
('management', 343, 331, 'admin/structure/taxonomy/%/fields/%/widget-type', 'admin/structure/taxonomy/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 57, 88, 323, 331, 343, 0, 0, 0),
('management', 344, 332, 'admin/config/people/accounts/fields/%/delete', 'admin/config/people/accounts/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 8, 48, 89, 324, 332, 344, 0, 0, 0),
('management', 345, 332, 'admin/config/people/accounts/fields/%/edit', 'admin/config/people/accounts/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 48, 89, 324, 332, 345, 0, 0, 0),
('management', 346, 332, 'admin/config/people/accounts/fields/%/field-settings', 'admin/config/people/accounts/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 48, 89, 324, 332, 346, 0, 0, 0),
('management', 347, 332, 'admin/config/people/accounts/fields/%/widget-type', 'admin/config/people/accounts/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 48, 89, 324, 332, 347, 0, 0, 0),
('management', 348, 166, 'admin/structure/types/manage/%/comment/display/default', 'admin/structure/types/manage/%/comment/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 37, 130, 166, 348, 0, 0, 0, 0),
('management', 349, 166, 'admin/structure/types/manage/%/comment/display/full', 'admin/structure/types/manage/%/comment/display/full', 'Full comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 37, 130, 166, 349, 0, 0, 0, 0),
('management', 350, 167, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 37, 130, 167, 350, 0, 0, 0, 0),
('management', 351, 339, 'admin/structure/types/manage/%/fields/%/delete', 'admin/structure/types/manage/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 37, 130, 328, 339, 351, 0, 0, 0),
('management', 352, 339, 'admin/structure/types/manage/%/fields/%/edit', 'admin/structure/types/manage/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 130, 328, 339, 352, 0, 0, 0),
('management', 353, 339, 'admin/structure/types/manage/%/fields/%/field-settings', 'admin/structure/types/manage/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 130, 328, 339, 353, 0, 0, 0),
('management', 354, 339, 'admin/structure/types/manage/%/fields/%/widget-type', 'admin/structure/types/manage/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 130, 328, 339, 354, 0, 0, 0),
('management', 355, 350, 'admin/structure/types/manage/%/comment/fields/%/delete', 'admin/structure/types/manage/%/comment/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 37, 130, 167, 350, 355, 0, 0, 0),
('management', 356, 350, 'admin/structure/types/manage/%/comment/fields/%/edit', 'admin/structure/types/manage/%/comment/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 130, 167, 350, 356, 0, 0, 0),
('management', 357, 350, 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 130, 167, 350, 357, 0, 0, 0),
('management', 358, 350, 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 130, 167, 350, 358, 0, 0, 0),
('management', 359, 8, 'admin/config/administration', 'admin/config/administration', 'Administration', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32313a2241646d696e697374726174696f6e20746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 8, 359, 0, 0, 0, 0, 0, 0, 0),
('management', 360, 12, 'admin/help/admin_menu', 'admin/help/admin_menu', 'admin_menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 360, 0, 0, 0, 0, 0, 0, 0),
('management', 361, 12, 'admin/help/og', 'admin/help/og', 'og', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 361, 0, 0, 0, 0, 0, 0, 0),
('management', 362, 12, 'admin/help/rules', 'admin/help/rules', 'rules', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 362, 0, 0, 0, 0, 0, 0, 0),
('management', 363, 359, 'admin/config/administration/admin_menu', 'admin/config/administration/admin_menu', 'Administration menu', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a2241646a7573742061646d696e697374726174696f6e206d656e752073657474696e67732e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 359, 363, 0, 0, 0, 0, 0, 0),
('management', 364, 61, 'admin/config/user-interface/modulefilter', 'admin/config/user-interface/modulefilter', 'Module filter', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a22436f6e66696775726520686f7720746865206d6f64756c65732070616765206c6f6f6b7320616e6420616374732e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 61, 364, 0, 0, 0, 0, 0, 0),
('management', 365, 8, 'admin/config/group/group-membership', 'admin/config/group/group-membership', 'OG membership types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a224d616e6167652067726f7570206d656d626572736869707320747970652c20696e636c7564696e67206669656c64732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 8, 365, 0, 0, 0, 0, 0, 0, 0),
('management', 366, 365, 'admin/config/group/group-membership/add', 'admin/config/group/group-membership/add', '', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 8, 365, 366, 0, 0, 0, 0, 0, 0),
('management', 367, 365, 'admin/config/group/group-membership/import', 'admin/config/group/group-membership/import', '', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 8, 365, 367, 0, 0, 0, 0, 0, 0),
('management', 368, 365, 'admin/config/group/group-membership/list', 'admin/config/group/group-membership/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 8, 365, 368, 0, 0, 0, 0, 0, 0),
('management', 369, 365, 'admin/config/group/group-membership/manage/%', 'admin/config/group/group-membership/manage/%', 'Edit', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 365, 369, 0, 0, 0, 0, 0, 0),
('management', 370, 369, 'admin/config/group/group-membership/manage/%/display', 'admin/config/group/group-membership/manage/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 365, 369, 370, 0, 0, 0, 0, 0),
('management', 371, 369, 'admin/config/group/group-membership/manage/%/fields', 'admin/config/group/group-membership/manage/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 8, 365, 369, 371, 0, 0, 0, 0, 0),
('management', 372, 369, 'admin/config/group/group-membership/manage/%/clone', 'admin/config/group/group-membership/manage/%/clone', 'Clone', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 365, 369, 372, 0, 0, 0, 0, 0),
('management', 373, 369, 'admin/config/group/group-membership/manage/%/%', 'admin/config/group/group-membership/manage/%/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 365, 369, 373, 0, 0, 0, 0, 0),
('management', 374, 369, 'admin/config/group/group-membership/manage/%/edit', 'admin/config/group/group-membership/manage/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 365, 369, 374, 0, 0, 0, 0, 0),
('management', 375, 370, 'admin/config/group/group-membership/manage/%/display/default', 'admin/config/group/group-membership/manage/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 365, 369, 370, 375, 0, 0, 0, 0),
('management', 376, 371, 'admin/config/group/group-membership/manage/%/fields/%', 'admin/config/group/group-membership/manage/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 365, 369, 371, 376, 0, 0, 0, 0),
('management', 377, 376, 'admin/config/group/group-membership/manage/%/fields/%/delete', 'admin/config/group/group-membership/manage/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 8, 365, 369, 371, 376, 377, 0, 0, 0),
('management', 378, 376, 'admin/config/group/group-membership/manage/%/fields/%/edit', 'admin/config/group/group-membership/manage/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 365, 369, 371, 376, 378, 0, 0, 0),
('management', 379, 376, 'admin/config/group/group-membership/manage/%/fields/%/field-settings', 'admin/config/group/group-membership/manage/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 365, 369, 371, 376, 379, 0, 0, 0),
('management', 380, 376, 'admin/config/group/group-membership/manage/%/fields/%/widget-type', 'admin/config/group/group-membership/manage/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 365, 369, 371, 376, 380, 0, 0, 0),
('navigation', 381, 0, 'civicrm', 'civicrm', 'CiviCRM', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 1, 0, 381, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 382, 8, 'admin/config/civicrm', 'admin/config/civicrm', 'CiviCRM', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33383a22436f6e666967757265204369766943524d20696e746567726174696f6e206d6f64756c65732e223b7d7d, 'system', 0, 0, 0, 0, -10, 3, 0, 1, 8, 382, 0, 0, 0, 0, 0, 0, 0),
('navigation', 383, 41, 'user/%/edit/name_and_address', 'user/%/edit/name_and_address', '', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 3, 0, 17, 41, 383, 0, 0, 0, 0, 0, 0, 0),
('navigation', 384, 0, 'civicrm/dashboard', 'civicrm', 'CiviCRM', 0x613a313a7b733a353a22616c746572223b623a313b7d, 'civicrm', 0, 0, 0, 0, 0, 1, 0, 384, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 385, 127, 'admin/structure/block/list/bartik/add', 'admin/structure/block/list/bartik/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 127, 385, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `menu_router`
--

CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';

--
-- Dumping data for table `menu_router`
--

INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'admin', 'Administration', 't', '', '', 'a:0:{}', 6, '', '', 9, 'modules/system/system.admin.inc'),
('admin/appearance', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_themes_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/appearance', 'Appearance', 't', '', '', 'a:0:{}', 6, 'Select and configure your themes.', 'left', -6, 'modules/system/system.admin.inc'),
('admin/appearance/default', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_default', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/default', 'Set default theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/disable', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_disable', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/disable', 'Disable theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/enable', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_enable', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/enable', 'Enable theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/install', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32373a227570646174655f6d616e616765725f696e7374616c6c5f666f726d223b693a313b733a353a227468656d65223b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'Install new theme', 't', '', '', 'a:0:{}', 388, '', '', 25, 'modules/update/update.manager.inc'),
('admin/appearance/list', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_themes_page', 0x613a303a7b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'List', 't', '', '', 'a:0:{}', 140, 'Select and configure your theme', '', -1, 'modules/system/system.admin.inc'),
('admin/appearance/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'Settings', 't', '', '', 'a:0:{}', 132, 'Configure default and theme specific settings.', '', 20, 'modules/system/system.admin.inc'),
('admin/appearance/settings/bartik', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a32303a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a363a2262617274696b223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Bartik', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/garland', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a373a226761726c616e64223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Garland', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/global', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Global settings', 't', '', '', 'a:0:{}', 140, '', '', -1, 'modules/system/system.admin.inc'),
('admin/appearance/settings/seven', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a383a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a353a22736576656e223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Seven', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/stark', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a353a22737461726b223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Stark', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/update', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a227570646174655f6d616e616765725f7570646174655f666f726d223b693a313b733a353a227468656d65223b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'Update', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/update/update.manager.inc'),
('admin/compact', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_compact_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/compact', 'Compact mode', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_config_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/config', 'Configuration', 't', '', '', 'a:0:{}', 6, 'Administer settings.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/administration', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/administration', 'Administration', 't', '', '', 'a:0:{}', 6, 'Administration tools.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/administration/admin_menu', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2261646d696e5f6d656e755f7468656d655f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/administration/admin_menu', 'Administration menu', 't', '', '', 'a:0:{}', 6, 'Adjust administration menu settings.', '', 0, 'sites/all/modules/admin_menu/admin_menu.inc'),
('admin/config/civicrm', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/civicrm', 'CiviCRM', 't', '', '', 'a:0:{}', 6, 'Configure CiviCRM integration modules.', 'left', -10, 'modules/system/system.admin.inc'),
('admin/config/content', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/content', 'Content authoring', 't', '', '', 'a:0:{}', 6, 'Settings related to formatting and authoring content.', 'left', -15, 'modules/system/system.admin.inc'),
('admin/config/content/formats', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2266696c7465725f61646d696e5f6f76657276696577223b7d, '', 15, 4, 0, '', 'admin/config/content/formats', 'Text formats', 't', '', '', 'a:0:{}', 6, 'Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%', 0x613a313a7b693a343b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'filter_admin_format_page', 0x613a313a7b693a303b693a343b7d, '', 30, 5, 0, '', 'admin/config/content/formats/%', '', 'filter_admin_format_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%/disable', 0x613a313a7b693a343b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', '_filter_disable_format_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32303a2266696c7465725f61646d696e5f64697361626c65223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/config/content/formats/%/disable', 'Disable text format', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/add', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'filter_admin_format_page', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/content/formats', 'admin/config/content/formats', 'Add text format', 't', '', '', 'a:0:{}', 388, '', '', 1, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/list', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2266696c7465725f61646d696e5f6f76657276696577223b7d, '', 31, 5, 1, 'admin/config/content/formats', 'admin/config/content/formats', 'List', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/development', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/development', 'Development', 't', '', '', 'a:0:{}', 6, 'Development tools.', 'right', -10, 'modules/system/system.admin.inc'),
('admin/config/development/logging', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32333a2273797374656d5f6c6f6767696e675f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/development/logging', 'Logging and errors', 't', '', '', 'a:0:{}', 6, 'Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.', '', -15, 'modules/system/system.admin.inc'),
('admin/config/development/maintenance', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32383a2273797374656d5f736974655f6d61696e74656e616e63655f6d6f6465223b7d, '', 15, 4, 0, '', 'admin/config/development/maintenance', 'Maintenance mode', 't', '', '', 'a:0:{}', 6, 'Take the site offline for maintenance or bring it back online.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/development/performance', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32373a2273797374656d5f706572666f726d616e63655f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/development/performance', 'Performance', 't', '', '', 'a:0:{}', 6, 'Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/group/group-membership', '', '', 'entity_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33323a226f675f6d656d626572736869705f747970655f6f766572766965775f666f726d223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b7d, '', 15, 4, 0, '', 'admin/config/group/group-membership', 'OG membership types', 't', '', '', 'a:0:{}', 6, 'Manage group memberships type, including fields.', '', 0, 'sites/all/modules/entity/includes/entity.ui.inc'),
('admin/config/group/group-membership/add', '', '', 'entity_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b7d, 'entity_ui_get_form', 0x613a333a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b693a313b4e3b693a323b733a333a22616464223b7d, '', 31, 5, 1, 'admin/config/group/group-membership', 'admin/config/group/group-membership', '', 'entity_ui_get_action_title', 'a:2:{i:0;s:3:"add";i:1;s:18:"og_membership_type";}', '', 'a:0:{}', 388, '', '', 0, 'sites/all/modules/og/includes/og.admin.inc'),
('admin/config/group/group-membership/import', '', '', 'entity_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33333a226f675f6d656d626572736869705f747970655f6f7065726174696f6e5f666f726d223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b693a323b4e3b693a333b733a363a22696d706f7274223b7d, '', 31, 5, 1, 'admin/config/group/group-membership', 'admin/config/group/group-membership', '', 'entity_ui_get_action_title', 'a:2:{i:0;s:6:"import";i:1;s:18:"og_membership_type";}', '', 'a:0:{}', 388, '', '', 0, 'sites/all/modules/entity/includes/entity.ui.inc'),
('admin/config/group/group-membership/list', '', '', 'entity_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33323a226f675f6d656d626572736869705f747970655f6f766572766965775f666f726d223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b7d, '', 31, 5, 1, 'admin/config/group/group-membership', 'admin/config/group/group-membership', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'sites/all/modules/entity/includes/entity.ui.inc'),
('admin/config/group/group-membership/manage/%', 0x613a313a7b693a353b613a313a7b733a31383a22656e746974795f6f626a6563745f6c6f6164223b613a313a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b7d7d7d, '', 'entity_access', 0x613a333a7b693a303b733a363a22757064617465223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b693a323b693a353b7d, 'entity_ui_get_form', 0x613a323a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/group/group-membership/manage/%', 'Edit', 'entity_label', 'a:2:{i:0;s:18:"og_membership_type";i:1;i:5;}', '', 'a:0:{}', 6, '', '', 0, 'sites/all/modules/og/includes/og.admin.inc'),
('admin/config/group/group-membership/manage/%/%', 0x613a323a7b693a353b613a313a7b733a31383a22656e746974795f6f626a6563745f6c6f6164223b613a313a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b7d7d693a363b4e3b7d, '', 'entity_access', 0x613a333a7b693a303b733a363a2264656c657465223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b693a323b693a353b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33333a226f675f6d656d626572736869705f747970655f6f7065726174696f6e5f666f726d223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b693a323b693a353b693a333b693a363b7d, '', 124, 7, 0, '', 'admin/config/group/group-membership/manage/%/%', '', 't', '', '', 'a:0:{}', 6, '', '', 0, 'sites/all/modules/entity/includes/entity.ui.inc'),
('admin/config/group/group-membership/manage/%/clone', 0x613a313a7b693a353b613a313a7b733a31383a22656e746974795f6f626a6563745f6c6f6164223b613a313a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b7d7d7d, '', 'entity_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b7d, 'entity_ui_get_form', 0x613a333a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b693a313b693a353b693a323b733a353a22636c6f6e65223b7d, '', 125, 7, 0, '', 'admin/config/group/group-membership/manage/%/clone', 'Clone', 't', '', '', 'a:0:{}', 6, '', '', 0, 'sites/all/modules/og/includes/og.admin.inc'),
('admin/config/group/group-membership/manage/%/display', 0x613a313a7b693a353b733a32333a226f675f6d656d626572736869705f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e69737465722067726f7570223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a226f675f6d656d62657273686970223b693a323b693a353b693a333b733a373a2264656661756c74223b7d, '', 125, 7, 1, 'admin/config/group/group-membership/manage/%', 'admin/config/group/group-membership/manage/%', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/group/group-membership/manage/%/display/default', 0x613a313a7b693a353b733a32333a226f675f6d656d626572736869705f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31363a2261646d696e69737465722067726f7570223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a226f675f6d656d62657273686970223b693a323b693a353b693a333b733a373a2264656661756c74223b7d, '', 251, 8, 1, 'admin/config/group/group-membership/manage/%/display', 'admin/config/group/group-membership/manage/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/group/group-membership/manage/%/edit', 0x613a313a7b693a353b613a313a7b733a31383a22656e746974795f6f626a6563745f6c6f6164223b613a313a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b7d7d7d, '', 'entity_access', 0x613a333a7b693a303b733a363a22757064617465223b693a313b733a31383a226f675f6d656d626572736869705f74797065223b693a323b693a353b7d, 'entity_ui_get_form', 0x613a323a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/group/group-membership/manage/%', 'admin/config/group/group-membership/manage/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'sites/all/modules/og/includes/og.admin.inc'),
('admin/config/group/group-membership/manage/%/fields', 0x613a313a7b693a353b733a32333a226f675f6d656d626572736869705f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e69737465722067726f7570223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a31333a226f675f6d656d62657273686970223b693a323b693a353b7d, '', 125, 7, 1, 'admin/config/group/group-membership/manage/%', 'admin/config/group/group-membership/manage/%', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/group/group-membership/manage/%/fields/%', 0x613a323a7b693a353b613a313a7b733a32333a226f675f6d656d626572736869705f747970655f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e69737465722067726f7570223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a373b7d, '', 250, 8, 0, '', 'admin/config/group/group-membership/manage/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:7;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/group/group-membership/manage/%/fields/%/delete', 0x613a323a7b693a353b613a313a7b733a32333a226f675f6d656d626572736869705f747970655f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e69737465722067726f7570223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a373b7d, '', 501, 9, 1, 'admin/config/group/group-membership/manage/%/fields/%', 'admin/config/group/group-membership/manage/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/group/group-membership/manage/%/fields/%/edit', 0x613a323a7b693a353b613a313a7b733a32333a226f675f6d656d626572736869705f747970655f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e69737465722067726f7570223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a373b7d, '', 501, 9, 1, 'admin/config/group/group-membership/manage/%/fields/%', 'admin/config/group/group-membership/manage/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/group/group-membership/manage/%/fields/%/field-settings', 0x613a323a7b693a353b613a313a7b733a32333a226f675f6d656d626572736869705f747970655f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e69737465722067726f7570223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a373b7d, '', 501, 9, 1, 'admin/config/group/group-membership/manage/%/fields/%', 'admin/config/group/group-membership/manage/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/group/group-membership/manage/%/fields/%/widget-type', 0x613a323a7b693a353b613a313a7b733a32333a226f675f6d656d626572736869705f747970655f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b693a353b693a323b733a313a2235223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e69737465722067726f7570223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a373b7d, '', 501, 9, 1, 'admin/config/group/group-membership/manage/%/fields/%', 'admin/config/group/group-membership/manage/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/media', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/media', 'Media', 't', '', '', 'a:0:{}', 6, 'Media tools.', 'left', -10, 'modules/system/system.admin.inc'),
('admin/config/media/file-system', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32373a2273797374656d5f66696c655f73797374656d5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/media/file-system', 'File system', 't', '', '', 'a:0:{}', 6, 'Tell Drupal where to store uploaded files and how they are accessed.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/media/image-styles', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'image_style_list', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/media/image-styles', 'Image styles', 't', '', '', 'a:0:{}', 6, 'Configure styles that can be used for resizing or adjusting images on display.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/add', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22696d6167655f7374796c655f6164645f666f726d223b7d, '', 31, 5, 1, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Add style', 't', '', '', 'a:0:{}', 388, 'Add a new image style.', '', 2, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/delete/%', 0x613a313a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b4e3b693a313b733a313a2231223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a22696d6167655f7374796c655f64656c6574655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/delete/%', 'Delete style', 't', '', '', 'a:0:{}', 6, 'Delete an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%', 0x613a313a7b693a353b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31363a22696d6167655f7374796c655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/edit/%', 'Edit style', 't', '', '', 'a:0:{}', 6, 'Configure an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/add/%', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a313a7b693a303b693a353b7d7d693a373b613a313a7b733a32383a22696d6167655f6566666563745f646566696e6974696f6e5f6c6f6164223b613a313a7b693a303b693a353b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31373a22696d6167655f6566666563745f666f726d223b693a313b693a353b693a323b693a373b7d, '', 250, 8, 0, '', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 't', '', '', 'a:0:{}', 6, 'Add a new effect to a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d693a373b613a313a7b733a31373a22696d6167655f6566666563745f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31373a22696d6167655f6566666563745f666f726d223b693a313b693a353b693a323b693a373b7d, '', 250, 8, 0, '', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 't', '', '', 'a:0:{}', 6, 'Edit an existing effect within a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%/delete', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d693a373b613a313a7b733a31373a22696d6167655f6566666563745f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32343a22696d6167655f6566666563745f64656c6574655f666f726d223b693a313b693a353b693a323b693a373b7d, '', 501, 9, 0, '', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 't', '', '', 'a:0:{}', 6, 'Delete an existing effect from a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/list', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'image_style_list', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'List', 't', '', '', 'a:0:{}', 140, 'List the current image styles on the site.', '', 1, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/revert/%', 0x613a313a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b4e3b693a313b733a313a2232223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a22696d6167655f7374796c655f7265766572745f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/revert/%', 'Revert style', 't', '', '', 'a:0:{}', 6, 'Revert an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-toolkit', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32393a2273797374656d5f696d6167655f746f6f6c6b69745f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/media/image-toolkit', 'Image toolkit', 't', '', '', 'a:0:{}', 6, 'Choose which image toolkit to use if you have installed optional toolkits.', '', 20, 'modules/system/system.admin.inc'),
('admin/config/people', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/people', 'People', 't', '', '', 'a:0:{}', 6, 'Configure user accounts.', 'left', -20, 'modules/system/system.admin.inc'),
('admin/config/people/accounts', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a22757365725f61646d696e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/people/accounts', 'Account settings', 't', '', '', 'a:0:{}', 6, 'Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.', '', -10, 'modules/user/user.admin.inc'),
('admin/config/people/accounts/display', '', '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a373a2264656661756c74223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/config/people/accounts/display/default', '', '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a373a2264656661756c74223b7d, '', 63, 6, 1, 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/full', '', '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a343a2266756c6c223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a343a2266756c6c223b7d, '', 63, 6, 1, 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'User account', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields', '', '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/people/accounts/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/delete', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/edit', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/field-settings', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/widget-type', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a22757365725f61646d696e5f73657474696e6773223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Settings', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/user/user.admin.inc'),
('admin/config/people/ip-blocking', '', '', 'user_access', 0x613a313a7b693a303b733a31383a22626c6f636b20495020616464726573736573223b7d, 'system_ip_blocking', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/people/ip-blocking', 'IP address blocking', 't', '', '', 'a:0:{}', 6, 'Manage blocked IP addresses.', '', 10, 'modules/system/system.admin.inc'),
('admin/config/people/ip-blocking/delete/%', 0x613a313a7b693a353b733a31353a22626c6f636b65645f69705f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a22626c6f636b20495020616464726573736573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a2273797374656d5f69705f626c6f636b696e675f64656c657465223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/regional', 'Regional and language', 't', '', '', 'a:0:{}', 6, 'Regional settings, localization and translation.', 'left', -5, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f646174655f74696d655f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/regional/date-time', 'Date and time', 't', '', '', 'a:0:{}', 6, 'Configure display formats for date and time.', '', -15, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_date_time_formats', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Formats', 't', '', '', 'a:0:{}', 132, 'Configure display format strings for date and time.', '', -9, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/delete', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33303a2273797374656d5f646174655f64656c6574655f666f726d61745f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 't', '', '', 'a:0:{}', 6, 'Allow users to delete a configured date format.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/edit', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33343a2273797374656d5f636f6e6669677572655f646174655f666f726d6174735f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 't', '', '', 'a:0:{}', 6, 'Allow users to edit a configured date format.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/add', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33343a2273797374656d5f636f6e6669677572655f646174655f666f726d6174735f666f726d223b7d, '', 63, 6, 1, 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time', 'Add format', 't', '', '', 'a:0:{}', 388, 'Allow users to add additional date formats.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/lookup', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_date_time_lookup', 0x613a303a7b7d, '', 63, 6, 0, '', 'admin/config/regional/date-time/formats/lookup', 'Date and time lookup', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f646174655f74696d655f73657474696e6773223b7d, '', 31, 5, 1, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Types', 't', '', '', 'a:0:{}', 140, 'Configure display formats for date and time.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/%/delete', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33353a2273797374656d5f64656c6574655f646174655f666f726d61745f747970655f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 't', '', '', 'a:0:{}', 6, 'Allow users to delete a configured date type.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/add', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a2273797374656d5f6164645f646174655f666f726d61745f747970655f666f726d223b7d, '', 63, 6, 1, 'admin/config/regional/date-time/types', 'admin/config/regional/date-time', 'Add date type', 't', '', '', 'a:0:{}', 388, 'Add new date type.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/settings', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f726567696f6e616c5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/regional/settings', 'Regional settings', 't', '', '', 'a:0:{}', 6, 'Settings for the site\'s default time zone and country.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/search', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/search', 'Search and metadata', 't', '', '', 'a:0:{}', 6, 'Local site search, metadata and SEO.', 'left', -10, 'modules/system/system.admin.inc'),
('admin/config/search/clean-urls', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f636c65616e5f75726c5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/search/clean-urls', 'Clean URLs', 't', '', '', 'a:0:{}', 6, 'Enable or disable clean URLs for your site.', '', 5, 'modules/system/system.admin.inc'),
('admin/config/search/clean-urls/check', '', '', '1', 0x613a303a7b7d, 'drupal_json_output', 0x613a313a7b693a303b613a313a7b733a363a22737461747573223b623a313b7d7d, '', 31, 5, 0, '', 'admin/config/search/clean-urls/check', 'Clean URL check', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/search/path', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_overview', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/search/path', 'URL aliases', 't', '', '', 'a:0:{}', 6, 'Change your site\'s URL paths by aliasing them.', '', -5, 'modules/path/path.admin.inc'),
('admin/config/search/path/add', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_edit', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/search/path', 'admin/config/search/path', 'Add alias', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/delete/%', 0x613a313a7b693a353b733a393a22706174685f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a22706174685f61646d696e5f64656c6574655f636f6e6669726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/search/path/delete/%', 'Delete alias', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/edit/%', 0x613a313a7b693a353b733a393a22706174685f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_edit', 0x613a313a7b693a303b693a353b7d, '', 62, 6, 0, '', 'admin/config/search/path/edit/%', 'Edit alias', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/list', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_overview', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/search/path', 'admin/config/search/path', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/path/path.admin.inc'),
('admin/config/search/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220736561726368223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a227365617263685f61646d696e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/search/settings', 'Search settings', 't', '', '', 'a:0:{}', 6, 'Configure relevance settings for search and other indexing options.', '', -10, 'modules/search/search.admin.inc'),
('admin/config/search/settings/reindex', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220736561726368223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a227365617263685f7265696e6465785f636f6e6669726d223b7d, '', 31, 5, 0, '', 'admin/config/search/settings/reindex', 'Clear index', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/search/search.admin.inc'),
('admin/config/services', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/services', 'Web services', 't', '', '', 'a:0:{}', 6, 'Tools related to web services.', 'right', 0, 'modules/system/system.admin.inc'),
('admin/config/services/rss-publishing', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f7273735f66656564735f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/services/rss-publishing', 'RSS publishing', 't', '', '', 'a:0:{}', 6, 'Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/system', 'System', 't', '', '', 'a:0:{}', 6, 'General system related configuration.', 'right', -20, 'modules/system/system.admin.inc'),
('admin/config/system/actions', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_manage', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/system/actions', 'Actions', 't', '', '', 'a:0:{}', 6, 'Manage the actions defined for your site.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f616374696f6e735f636f6e666967757265223b7d, '', 31, 5, 0, '', 'admin/config/system/actions/configure', 'Configure an advanced action', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/delete/%', 0x613a313a7b693a353b733a31323a22616374696f6e735f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a2273797374656d5f616374696f6e735f64656c6574655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/system/actions/delete/%', 'Delete action', 't', '', '', 'a:0:{}', 6, 'Delete an action.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/manage', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_manage', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/system/actions', 'admin/config/system/actions', 'Manage actions', 't', '', '', 'a:0:{}', 140, 'Manage the actions defined for your site.', '', -2, 'modules/system/system.admin.inc'),
('admin/config/system/actions/orphan', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_remove_orphans', 0x613a303a7b7d, '', 31, 5, 0, '', 'admin/config/system/actions/orphan', 'Remove orphans', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/cron', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a2273797374656d5f63726f6e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/system/cron', 'Cron', 't', '', '', 'a:0:{}', 6, 'Manage automatic site maintenance tasks.', '', 20, 'modules/system/system.admin.inc'),
('admin/config/system/site-information', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a2273797374656d5f736974655f696e666f726d6174696f6e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/system/site-information', 'Site information', 't', '', '', 'a:0:{}', 6, 'Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/user-interface', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/user-interface', 'User interface', 't', '', '', 'a:0:{}', 6, 'Tools that enhance the user interface.', 'right', -15, 'modules/system/system.admin.inc'),
('admin/config/user-interface/modulefilter', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e6973746572206d6f64756c652066696c746572223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a226d6f64756c655f66696c7465725f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/user-interface/modulefilter', 'Module filter', 't', '', '', 'a:0:{}', 6, 'Configure how the modules page looks and acts.', '', 0, 'sites/all/modules/module_filter/module_filter.admin.inc'),
('admin/config/user-interface/shortcut', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261646d696e69737465722073686f727463757473223b7d, 'shortcut_set_admin', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/user-interface/shortcut', 'Shortcuts', 't', '', '', 'a:0:{}', 6, 'Add and modify shortcut sets.', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f637573746f6d697a65223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 'shortcut_set_title_callback', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/add-link', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a2273686f72746375745f6c696e6b5f616464223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Add shortcut', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/add-link-inline', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'shortcut_link_add_inline', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/config/user-interface/shortcut/%/add-link-inline', 'Add shortcut', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/delete', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_delete_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a2273686f72746375745f7365745f64656c6574655f666f726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/edit', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f656469745f666f726d223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit set name', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/links', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f637573746f6d697a65223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'List links', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/add-set', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261646d696e69737465722073686f727463757473223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273686f72746375745f7365745f6164645f666f726d223b7d, '', 31, 5, 1, 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Add shortcut set', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/link/%', 0x613a313a7b693a353b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'shortcut_link_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a2273686f72746375745f6c696e6b5f65646974223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/link/%/delete', 0x613a313a7b693a353b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'shortcut_link_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32303a2273686f72746375745f6c696e6b5f64656c657465223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/workflow', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/workflow', 'Workflow', 't', '', '', 'a:0:{}', 6, 'Content workflow, editorial workflow tools.', 'right', 5, 'modules/system/system.admin.inc'),
('admin/config/workflow/rules/autocomplete_tags', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e69737465722072756c6573223b7d, 'rules_autocomplete_tags', 0x613a313a7b693a303b693a353b7d, '', 31, 5, 0, '', 'admin/config/workflow/rules/autocomplete_tags', 'Rules tags autocomplete', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/rules/ui/ui.forms.inc'),
('admin/config/workflow/rules/upgrade', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e69737465722072756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a2272756c65735f757067726164655f666f726d223b7d, '', 31, 5, 0, '', 'admin/config/workflow/rules/upgrade', 'Upgrade', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/rules/includes/rules.upgrade.inc'),
('admin/config/workflow/rules/upgrade/clear', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e69737465722072756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a2272756c65735f757067726164655f636f6e6669726d5f636c6561725f666f726d223b7d, '', 63, 6, 0, '', 'admin/config/workflow/rules/upgrade/clear', 'Clear', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/rules/includes/rules.upgrade.inc'),
('admin/content', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261636365737320636f6e74656e74206f76657276696577223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a226e6f64655f61646d696e5f636f6e74656e74223b7d, '', 3, 2, 0, '', 'admin/content', 'Content', 't', '', '', 'a:0:{}', 6, 'Administer content and comments.', '', -10, 'modules/node/node.admin.inc'),
('admin/content/comment', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a303a7b7d, '', 7, 3, 1, 'admin/content', 'admin/content', 'Comments', 't', '', '', 'a:0:{}', 134, 'List and edit site comments and the comment approval queue.', '', 0, 'modules/comment/comment.admin.inc'),
('admin/content/comment/approval', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a313a7b693a303b733a383a22617070726f76616c223b7d, '', 15, 4, 1, 'admin/content/comment', 'admin/content', 'Unapproved comments', 'comment_count_unpublished', '', '', 'a:0:{}', 132, '', '', 0, 'modules/comment/comment.admin.inc'),
('admin/content/comment/new', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a303a7b7d, '', 15, 4, 1, 'admin/content/comment', 'admin/content', 'Published comments', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/comment/comment.admin.inc'),
('admin/content/node', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261636365737320636f6e74656e74206f76657276696577223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a226e6f64655f61646d696e5f636f6e74656e74223b7d, '', 7, 3, 1, 'admin/content', 'admin/content', 'Content', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/node/node.admin.inc'),
('admin/dashboard', '', '', 'user_access', 0x613a313a7b693a303b733a31363a226163636573732064617368626f617264223b7d, 'dashboard_admin', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/dashboard', 'Dashboard', 't', '', '', 'a:0:{}', 6, 'View and customize your dashboard.', '', -15, ''),
('admin/dashboard/block-content/%/%', 0x613a323a7b693a333b4e3b693a343b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'dashboard_show_block_content', 0x613a323a7b693a303b693a333b693a313b693a343b7d, '', 28, 5, 0, '', 'admin/dashboard/block-content/%/%', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/dashboard/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'dashboard_admin_blocks', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/dashboard/configure', 'Configure available dashboard blocks', 't', '', '', 'a:0:{}', 4, 'Configure which blocks can be shown on the dashboard.', '', 0, ''),
('admin/dashboard/customize', '', '', 'user_access', 0x613a313a7b693a303b733a31363a226163636573732064617368626f617264223b7d, 'dashboard_admin', 0x613a313a7b693a303b623a313b7d, '', 7, 3, 0, '', 'admin/dashboard/customize', 'Customize dashboard', 't', '', '', 'a:0:{}', 4, 'Customize your dashboard.', '', 0, ''),
('admin/dashboard/drawer', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'dashboard_show_disabled', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/dashboard/drawer', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/dashboard/update', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'dashboard_update', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/dashboard/update', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/help', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_main', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/help', 'Help', 't', '', '', 'a:0:{}', 6, 'Reference for usage, configuration, and modules.', '', 9, 'modules/help/help.admin.inc'),
('admin/help/admin_menu', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/admin_menu', 'admin_menu', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/block', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/block', 'block', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/color', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/color', 'color', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/comment', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/comment', 'comment', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/contextual', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/contextual', 'contextual', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/dashboard', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/dashboard', 'dashboard', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/dblog', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/dblog', 'dblog', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field', 'field', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field_sql_storage', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field_sql_storage', 'field_sql_storage', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field_ui', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field_ui', 'field_ui', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/file', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/file', 'file', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/filter', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/filter', 'filter', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/help', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/help', 'help', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/image', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/image', 'image', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/list', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/list', 'list', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/menu', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/menu', 'menu', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/node', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/node', 'node', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/number', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/number', 'number', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/og', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/og', 'og', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/options', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/options', 'options', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/path', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/path', 'path', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/rdf', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/rdf', 'rdf', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/rules', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/rules', 'rules', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/search', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/search', 'search', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/shortcut', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/shortcut', 'shortcut', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/system', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/system', 'system', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/taxonomy', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/taxonomy', 'taxonomy', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/text', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/text', 'text', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/update', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/update', 'update', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/user', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/user', 'user', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/index', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_index', 0x613a303a7b7d, '', 3, 2, 1, 'admin', 'admin', 'Index', 't', '', '', 'a:0:{}', 132, '', '', -18, 'modules/system/system.admin.inc'),
('admin/modules', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 3, 2, 0, '', 'admin/modules', 'Modules', 't', '', '', 'a:0:{}', 6, 'Extend site functionality.', '', -2, 'modules/system/system.admin.inc'),
('admin/modules/install', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32373a227570646174655f6d616e616765725f696e7374616c6c5f666f726d223b693a313b733a363a226d6f64756c65223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'Install new module', 't', '', '', 'a:0:{}', 388, '', '', 25, 'modules/update/update.manager.inc'),
('admin/modules/list', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'List', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/system/system.admin.inc'),
('admin/modules/list/confirm', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 15, 4, 0, '', 'admin/modules/list/confirm', 'List', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/modules/uninstall', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f6d6f64756c65735f756e696e7374616c6c223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'Uninstall', 't', '', '', 'a:0:{}', 132, '', '', 20, 'modules/system/system.admin.inc'),
('admin/modules/uninstall/confirm', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f6d6f64756c65735f756e696e7374616c6c223b7d, '', 15, 4, 0, '', 'admin/modules/uninstall/confirm', 'Uninstall', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/modules/update', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a227570646174655f6d616e616765725f7570646174655f666f726d223b693a313b733a363a226d6f64756c65223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'Update', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/update/update.manager.inc'),
('admin/people', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a343a226c697374223b7d, '', 3, 2, 0, '', 'admin/people', 'People', 't', '', '', 'a:0:{}', 6, 'Manage user accounts, roles, and permissions.', 'left', -4, 'modules/user/user.admin.inc'),
('admin/people/create', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a363a22637265617465223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'Add user', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/user/user.admin.inc'),
('admin/people/people', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a343a226c697374223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'List', 't', '', '', 'a:0:{}', 140, 'Find and manage people interacting with your site.', '', -10, 'modules/user/user.admin.inc'),
('admin/people/permissions', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a22757365725f61646d696e5f7065726d697373696f6e73223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', 132, 'Determine access to features by selecting permissions for roles.', '', 0, 'modules/user/user.admin.inc'),
('admin/people/permissions/list', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a22757365725f61646d696e5f7065726d697373696f6e73223b7d, '', 15, 4, 1, 'admin/people/permissions', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', 140, 'Determine access to features by selecting permissions for roles.', '', -8, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31363a22757365725f61646d696e5f726f6c6573223b7d, '', 15, 4, 1, 'admin/people/permissions', 'admin/people', 'Roles', 't', '', '', 'a:0:{}', 132, 'List, edit, or add user roles.', '', -5, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles/delete/%', 0x613a313a7b693a353b733a31343a22757365725f726f6c655f6c6f6164223b7d, '', 'user_role_edit_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33303a22757365725f61646d696e5f726f6c655f64656c6574655f636f6e6669726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/people/permissions/roles/delete/%', 'Delete role', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles/edit/%', 0x613a313a7b693a353b733a31343a22757365725f726f6c655f6c6f6164223b7d, '', 'user_role_edit_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31353a22757365725f61646d696e5f726f6c65223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/people/permissions/roles/edit/%', 'Edit role', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.admin.inc'),
('admin/reports', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/reports', 'Reports', 't', '', '', 'a:0:{}', 6, 'View reports, updates, and errors.', 'left', 5, 'modules/system/system.admin.inc'),
('admin/reports/access-denied', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a31333a226163636573732064656e696564223b7d, '', 7, 3, 0, '', 'admin/reports/access-denied', 'Top \'access denied\' errors', 't', '', '', 'a:0:{}', 6, 'View \'access denied\' errors (403s).', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/dblog', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_overview', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/dblog', 'Recent log messages', 't', '', '', 'a:0:{}', 6, 'View events that have recently been logged.', '', -1, 'modules/dblog/dblog.admin.inc'),
('admin/reports/event/%', 0x613a313a7b693a333b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_event', 0x613a313a7b693a303b693a333b7d, '', 14, 4, 0, '', 'admin/reports/event/%', 'Details', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/fields', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'field_ui_fields_list', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/fields', 'Field list', 't', '', '', 'a:0:{}', 6, 'Overview of fields on all entity types.', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/reports/page-not-found', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a31343a2270616765206e6f7420666f756e64223b7d, '', 7, 3, 0, '', 'admin/reports/page-not-found', 'Top \'page not found\' errors', 't', '', '', 'a:0:{}', 6, 'View \'page not found\' errors (404s).', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/search', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a363a22736561726368223b7d, '', 7, 3, 0, '', 'admin/reports/search', 'Top search phrases', 't', '', '', 'a:0:{}', 6, 'View most popular search phrases.', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/status', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_status', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/status', 'Status report', 't', '', '', 'a:0:{}', 6, 'Get a status report about your site\'s operation and any detected problems.', '', -60, 'modules/system/system.admin.inc'),
('admin/reports/status/php', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_php', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/reports/status/php', 'PHP', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/reports/status/rebuild', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a226e6f64655f636f6e6669677572655f72656275696c645f636f6e6669726d223b7d, '', 15, 4, 0, '', 'admin/reports/status/rebuild', 'Rebuild permissions', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/node/node.admin.inc');
INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/reports/status/run-cron', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_run_cron', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/reports/status/run-cron', 'Run cron', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/reports/updates', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'module_filter_update_status', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/updates', 'Available updates', 't', '', '', 'a:0:{}', 6, 'Get a status report about available updates for your installed modules and themes.', '', -50, 'sites/all/modules/module_filter/module_filter.pages.inc'),
('admin/reports/updates/check', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'update_manual_status', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/reports/updates/check', 'Manual update check', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/update/update.fetch.inc'),
('admin/reports/updates/install', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32373a227570646174655f6d616e616765725f696e7374616c6c5f666f726d223b693a313b733a363a227265706f7274223b7d, '', 15, 4, 1, 'admin/reports/updates', 'admin/reports/updates', 'Install new module or theme', 't', '', '', 'a:0:{}', 388, '', '', 25, 'modules/update/update.manager.inc'),
('admin/reports/updates/list', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'module_filter_update_status', 0x613a303a7b7d, '', 15, 4, 1, 'admin/reports/updates', 'admin/reports/updates', 'List', 't', '', '', 'a:0:{}', 140, '', '', 0, 'sites/all/modules/module_filter/module_filter.pages.inc'),
('admin/reports/updates/settings', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31353a227570646174655f73657474696e6773223b7d, '', 15, 4, 1, 'admin/reports/updates', 'admin/reports/updates', 'Settings', 't', '', '', 'a:0:{}', 132, '', '', 50, 'modules/update/update.settings.inc'),
('admin/reports/updates/update', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a227570646174655f6d616e616765725f7570646174655f666f726d223b693a313b733a363a227265706f7274223b7d, '', 15, 4, 1, 'admin/reports/updates', 'admin/reports/updates', 'Update', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/update/update.manager.inc'),
('admin/structure', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/structure', 'Structure', 't', '', '', 'a:0:{}', 6, 'Administer blocks, content types, menus, etc.', 'right', -8, 'modules/system/system.admin.inc'),
('admin/structure/block', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'block_admin_display', 0x613a313a7b693a303b733a353a22736576656e223b7d, '', 7, 3, 0, '', 'admin/structure/block', 'Blocks', 't', '', '', 'a:0:{}', 6, 'Configure what block content appears in your site\'s sidebars and other regions.', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 15, 4, 1, 'admin/structure/block', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/bartik', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a32303a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a363a2262617274696b223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/bartik', 'Bartik', 't', '', '_block_custom_theme', 'a:1:{i:0;s:6:"bartik";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/garland', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a373a226761726c616e64223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/garland', 'Garland', 't', '', '_block_custom_theme', 'a:1:{i:0;s:7:"garland";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/seven', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a383a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a353a22736576656e223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/seven', 'Seven', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:"seven";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/stark', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a353a22737461726b223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/stark', 'Stark', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:"stark";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/bartik', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a32303a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a363a2262617274696b223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Bartik', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/bartik/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/bartik', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/garland', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a373a226761726c616e64223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Garland', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/garland/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/garland', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/seven', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a383a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a353a22736576656e223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Seven', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/block/block.admin.inc'),
('admin/structure/block/list/stark', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a353a22737461726b223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Stark', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/stark/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/stark', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32313a22626c6f636b5f61646d696e5f636f6e666967757265223b693a313b693a343b693a323b693a353b7d, '', 60, 6, 0, '', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/configure', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32313a22626c6f636b5f61646d696e5f636f6e666967757265223b693a313b693a343b693a323b693a353b7d, '', 121, 7, 2, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/delete', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32353a22626c6f636b5f637573746f6d5f626c6f636b5f64656c657465223b693a313b693a343b693a323b693a353b7d, '', 121, 7, 0, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Delete block', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/menu', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_overview_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/structure/menu', 'Menus', 't', '', '', 'a:0:{}', 6, 'Add new menus to your site, edit existing menus, and rename and reorganize menu links.', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/add', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226d656e755f656469745f6d656e75223b693a313b733a333a22616464223b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'Add menu', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/delete', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_item_delete_page', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/delete', 'Delete menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/edit', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31343a226d656e755f656469745f6974656d223b693a313b733a343a2265646974223b693a323b693a343b693a333b4e3b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/edit', 'Edit menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/reset', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a226d656e755f72657365745f6974656d5f636f6e6669726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/reset', 'Reset menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/list', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_overview_page', 0x613a303a7b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'List menus', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a226d656e755f6f766572766965775f666f726d223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/structure/menu/manage/%', 'Customize menu', 'menu_overview_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/add', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31343a226d656e755f656469745f6974656d223b693a313b733a333a22616464223b693a323b4e3b693a333b693a343b7d, '', 61, 6, 1, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Add link', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/delete', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_delete_menu_page', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/manage/%/delete', 'Delete menu', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/edit', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31343a226d656e755f656469745f6d656e75223b693a313b733a343a2265646974223b693a323b693a343b7d, '', 61, 6, 3, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Edit menu', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/list', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a226d656e755f6f766572766965775f666f726d223b693a313b693a343b7d, '', 61, 6, 3, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'List links', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/parents', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_parent_options_js', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/structure/menu/parents', 'Parent menu items', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/structure/menu/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a226d656e755f636f6e666967757265223b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'Settings', 't', '', '', 'a:0:{}', 132, '', '', 5, 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/structure/taxonomy', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a227461786f6e6f6d795f6f766572766965775f766f636162756c6172696573223b7d, '', 7, 3, 0, '', 'admin/structure/taxonomy', 'Taxonomy', 't', '', '', 'a:0:{}', 6, 'Manage tagging, categorization, and classification of your content.', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a227461786f6e6f6d795f6f766572766965775f7465726d73223b693a313b693a333b7d, '', 14, 4, 0, '', 'admin/structure/taxonomy/%', '', 'entity_label', 'a:2:{i:0;s:19:"taxonomy_vocabulary";i:1;i:3;}', '', 'a:0:{}', 6, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/add', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31383a227461786f6e6f6d795f666f726d5f7465726d223b693a313b613a303a7b7d693a323b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Add term', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/display', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a373a2264656661756c74223b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/display/default', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a373a2264656661756c74223b7d, '', 59, 6, 1, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/display/full', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a343a2266756c6c223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a343a2266756c6c223b7d, '', 59, 6, 1, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Taxonomy term page', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/edit', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a227461786f6e6f6d795f666f726d5f766f636162756c617279223b693a313b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', -10, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/fields', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 58, 6, 0, '', 'admin/structure/taxonomy/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/delete', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/edit', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/field-settings', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/widget-type', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/list', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a227461786f6e6f6d795f6f766572766965775f7465726d73223b693a313b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'List', 't', '', '', 'a:0:{}', 140, '', '', -20, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/add', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a227461786f6e6f6d795f666f726d5f766f636162756c617279223b7d, '', 15, 4, 1, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Add vocabulary', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/list', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a227461786f6e6f6d795f6f766572766965775f766f636162756c6172696573223b7d, '', 15, 4, 1, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/types', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'node_overview_types', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/structure/types', 'Content types', 't', '', '', 'a:0:{}', 6, 'Manage content types, including default status, front page promotion, comment settings, etc.', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/add', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a226e6f64655f747970655f666f726d223b7d, '', 15, 4, 1, 'admin/structure/types', 'admin/structure/types', 'Add content type', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/list', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'node_overview_types', 0x613a303a7b7d, '', 15, 4, 1, 'admin/structure/types', 'admin/structure/types', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226e6f64655f747970655f666f726d223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/structure/types/manage/%', 'Edit content type', 'node_type_page_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/comment/display', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment display', 't', '', '', 'a:0:{}', 132, '', '', 4, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/display/default', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 247, 8, 1, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/display/full', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a343a2266756c6c223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a343a2266756c6c223b7d, '', 247, 8, 1, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Full comment', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b7d, '', 123, 7, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment fields', 't', '', '', 'a:0:{}', 132, '', '', 3, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a373b7d, '', 246, 8, 0, '', 'admin/structure/types/manage/%/comment/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:7;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/delete', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/edit', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/field-settings', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/widget-type', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/delete', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226e6f64655f747970655f64656c6574655f636f6e6669726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/structure/types/manage/%/delete', 'Delete', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/display', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/default', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/full', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a343a2266756c6c223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a343a2266756c6c223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Full content', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/rss', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a333a22727373223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a333a22727373223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'RSS', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/search_index', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a31323a227365617263685f696e646578223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a31323a227365617263685f696e646578223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search index', 't', '', '', 'a:0:{}', 132, '', '', 3, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/search_result', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a31333a227365617263685f726573756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a31333a227365617263685f726573756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search result highlighting input', 't', '', '', 'a:0:{}', 132, '', '', 4, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/teaser', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a363a22746561736572223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a363a22746561736572223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Teaser', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/edit', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226e6f64655f747970655f666f726d223b693a313b693a343b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/fields', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a363b7d, '', 122, 7, 0, '', 'admin/structure/types/manage/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:6;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/delete', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/edit', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/field-settings', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/widget-type', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/tasks', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 1, 'admin', 'admin', 'Tasks', 't', '', '', 'a:0:{}', 140, '', '', -20, 'modules/system/system.admin.inc'),
('admin/update/ready', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a227570646174655f6d616e616765725f7570646174655f72656164795f666f726d223b7d, '', 7, 3, 0, '', 'admin/update/ready', 'Ready to update', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/update/update.manager.inc'),
('admin_menu/flush-cache', '', '', 'user_access', 0x613a313a7b693a303b733a31323a22666c75736820636163686573223b7d, 'admin_menu_flush_cache', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin_menu/flush-cache', '', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/admin_menu/admin_menu.inc'),
('batch', '', '', '1', 0x613a303a7b7d, 'system_batch_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'batch', '', 't', '', '_system_batch_theme', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('civicrm', '', '', '1', 0x613a303a7b7d, 'civicrm_invoke', 0x613a303a7b7d, '', 1, 1, 0, '', 'civicrm', 'CiviCRM', 't', '', '', 'a:0:{}', 4, '', '', 0, ''),
('comment/%', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261636365737320636f6d6d656e7473223b7d, 'comment_permalink', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'comment/%', 'Comment permalink', 't', '', '', 'a:0:{}', 6, '', '', 0, ''),
('comment/%/approve', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_approve', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 0, '', 'comment/%/approve', 'Approve', 't', '', '', 'a:0:{}', 6, '', '', 1, 'modules/comment/comment.pages.inc'),
('comment/%/delete', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_confirm_delete_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/comment/comment.admin.inc'),
('comment/%/edit', 0x613a313a7b693a313b733a31323a22636f6d6d656e745f6c6f6164223b7d, '', 'comment_access', 0x613a323a7b693a303b733a343a2265646974223b693a313b693a313b7d, 'comment_edit_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, ''),
('comment/%/view', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261636365737320636f6d6d656e7473223b7d, 'comment_permalink', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'View comment', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('comment/reply/%', 0x613a313a7b693a323b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a323b7d, 'comment_reply', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'comment/reply/%', 'Add new comment', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/comment/comment.pages.inc'),
('ctools/autocomplete/%', 0x613a313a7b693a323b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_content_autocomplete_entity', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'ctools/autocomplete/%', '', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/ctools/includes/content.menu.inc'),
('ctools/context/ajax/access/add', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_access_ajax_add', 0x613a303a7b7d, '', 31, 5, 0, '', 'ctools/context/ajax/access/add', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/ctools/includes/context-access-admin.inc'),
('ctools/context/ajax/access/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_access_ajax_edit', 0x613a303a7b7d, '', 31, 5, 0, '', 'ctools/context/ajax/access/configure', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/ctools/includes/context-access-admin.inc'),
('ctools/context/ajax/access/delete', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_access_ajax_delete', 0x613a303a7b7d, '', 31, 5, 0, '', 'ctools/context/ajax/access/delete', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/ctools/includes/context-access-admin.inc'),
('ctools/context/ajax/add', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_context_ajax_item_add', 0x613a303a7b7d, '', 15, 4, 0, '', 'ctools/context/ajax/add', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/ctools/includes/context-admin.inc'),
('ctools/context/ajax/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_context_ajax_item_edit', 0x613a303a7b7d, '', 15, 4, 0, '', 'ctools/context/ajax/configure', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/ctools/includes/context-admin.inc'),
('ctools/context/ajax/delete', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_context_ajax_item_delete', 0x613a303a7b7d, '', 15, 4, 0, '', 'ctools/context/ajax/delete', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/ctools/includes/context-admin.inc'),
('entityreference/autocomplete/single/%/%/%', 0x613a333a7b693a333b4e3b693a343b4e3b693a353b4e3b7d, '', 'entityreference_autocomplete_access_callback', 0x613a343a7b693a303b693a323b693a313b693a333b693a323b693a343b693a333b693a353b7d, 'entityreference_autocomplete_callback', 0x613a343a7b693a303b693a323b693a313b693a333b693a323b693a343b693a333b693a353b7d, '', 56, 6, 0, '', 'entityreference/autocomplete/single/%/%/%', 'Entity Reference Autocomplete', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('entityreference/autocomplete/tags/%/%/%', 0x613a333a7b693a333b4e3b693a343b4e3b693a353b4e3b7d, '', 'entityreference_autocomplete_access_callback', 0x613a343a7b693a303b693a323b693a313b693a333b693a323b693a343b693a333b693a353b7d, 'entityreference_autocomplete_callback', 0x613a343a7b693a303b693a323b693a313b693a333b693a323b693a343b693a333b693a353b7d, '', 56, 6, 0, '', 'entityreference/autocomplete/tags/%/%/%', 'Entity Reference Autocomplete', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('file/ajax', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'file_ajax_upload', 0x613a303a7b7d, 'ajax_deliver', 3, 2, 0, '', 'file/ajax', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, ''),
('file/progress', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'file_ajax_progress', 0x613a303a7b7d, '', 3, 2, 0, '', 'file/progress', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, ''),
('filter/tips', '', '', '1', 0x613a303a7b7d, 'filter_tips_long', 0x613a303a7b7d, '', 3, 2, 0, '', 'filter/tips', 'Compose tips', 't', '', '', 'a:0:{}', 20, '', '', 0, 'modules/filter/filter.pages.inc'),
('filter/tips/%', 0x613a313a7b693a323b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', 'filter_access', 0x613a313a7b693a303b693a323b7d, 'filter_tips_long', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'filter/tips/%', 'Compose tips', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.pages.inc'),
('js/admin_menu/cache', '', '', 'user_access', 0x613a313a7b693a303b733a32363a226163636573732061646d696e697374726174696f6e206d656e75223b7d, 'admin_menu_js_cache', 0x613a303a7b7d, 'admin_menu_deliver', 7, 3, 0, '', 'js/admin_menu/cache', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('node', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'node_page_default', 0x613a303a7b7d, '', 1, 1, 0, '', 'node', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('node/%', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a313b7d, 'node_page_view', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'node/%', '', 'node_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', 6, '', '', 0, ''),
('node/%/delete', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a363a2264656c657465223b693a313b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31393a226e6f64655f64656c6574655f636f6e6669726d223b693a313b693a313b7d, '', 5, 3, 2, 'node/%', 'node/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/node/node.pages.inc'),
('node/%/edit', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a363a22757064617465223b693a313b693a313b7d, 'node_page_edit', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 3, 'node/%', 'node/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/node/node.pages.inc'),
('node/%/revisions', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', '_node_revision_access', 0x613a313a7b693a303b693a313b7d, 'node_revision_overview', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'node/%', 'node/%', 'Revisions', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/node/node.pages.inc'),
('node/%/revisions/%/delete', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a323a7b693a303b693a313b693a313b733a363a2264656c657465223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226e6f64655f7265766973696f6e5f64656c6574655f636f6e6669726d223b693a313b693a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/delete', 'Delete earlier revision', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc'),
('node/%/revisions/%/revert', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a323a7b693a303b693a313b693a313b733a363a22757064617465223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226e6f64655f7265766973696f6e5f7265766572745f636f6e6669726d223b693a313b693a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/revert', 'Revert to earlier revision', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc'),
('node/%/revisions/%/view', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a313a7b693a303b693a313b7d, 'node_show', 0x613a323a7b693a303b693a313b693a313b623a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/view', 'Revisions', 't', '', '', 'a:0:{}', 6, '', '', 0, ''),
('node/%/view', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a313b7d, 'node_page_view', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'node/%', 'node/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('node/add', '', '', '_node_add_access', 0x613a303a7b7d, 'node_add_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'node/add', 'Add content', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc'),
('node/add/article', '', '', 'node_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a373a2261727469636c65223b7d, 'node_add', 0x613a313a7b693a303b733a373a2261727469636c65223b7d, '', 7, 3, 0, '', 'node/add/article', 'Article', 'check_plain', '', '', 'a:0:{}', 6, 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', 0, 'modules/node/node.pages.inc'),
('node/add/page', '', '', 'node_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a343a2270616765223b7d, 'node_add', 0x613a313a7b693a303b733a343a2270616765223b7d, '', 7, 3, 0, '', 'node/add/page', 'Basic page', 'check_plain', '', '', 'a:0:{}', 6, 'Use <em>basic pages</em> for your static content, such as an \'About us\' page.', '', 0, 'modules/node/node.pages.inc'),
('og/autocomplete/single/%/%/%/%', 0x613a343a7b693a333b4e3b693a343b4e3b693a353b4e3b693a363b4e3b7d, '', '1', 0x613a303a7b7d, 'og_entityreference_autocomplete_callback', 0x613a353a7b693a303b693a323b693a313b693a333b693a323b693a343b693a333b693a353b693a343b693a363b7d, '', 112, 7, 0, '', 'og/autocomplete/single/%/%/%/%', 'Entity Reference Autocomplete', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('og/autocomplete/tags/%/%/%/%', 0x613a343a7b693a333b4e3b693a343b4e3b693a353b4e3b693a363b4e3b7d, '', '1', 0x613a303a7b7d, 'og_entityreference_autocomplete_callback', 0x613a353a7b693a303b693a323b693a313b693a333b693a323b693a343b693a333b693a353b693a343b693a363b7d, '', 112, 7, 0, '', 'og/autocomplete/tags/%/%/%/%', 'Entity Reference Autocomplete', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('rss.xml', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'node_feed', 0x613a323a7b693a303b623a303b693a313b613a303a7b7d7d, '', 1, 1, 0, '', 'rss.xml', 'RSS feed', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('search', '', '', 'search_is_active', 0x613a303a7b7d, 'search_view', 0x613a303a7b7d, '', 1, 1, 0, '', 'search', 'Search', 't', '', '', 'a:0:{}', 20, '', '', 0, 'modules/search/search.pages.inc'),
('search/node', '', '', '_search_menu_access', 0x613a313a7b693a303b733a343a226e6f6465223b7d, 'search_view', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b733a303a22223b7d, '', 3, 2, 1, 'search', 'search', 'Content', 't', '', '', 'a:0:{}', 132, '', '', -10, 'modules/search/search.pages.inc'),
('search/node/%', 0x613a313a7b693a323b613a313a7b733a31343a226d656e755f7461696c5f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, 0x613a313a7b693a323b733a31363a226d656e755f7461696c5f746f5f617267223b7d, '_search_menu_access', 0x613a313a7b693a303b733a343a226e6f6465223b7d, 'search_view', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b693a323b7d, '', 6, 3, 1, 'search/node', 'search/node/%', 'Content', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('search/user', '', '', '_search_menu_access', 0x613a313a7b693a303b733a343a2275736572223b7d, 'search_view', 0x613a323a7b693a303b733a343a2275736572223b693a313b733a303a22223b7d, '', 3, 2, 1, 'search', 'search', 'Users', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('search/user/%', 0x613a313a7b693a323b613a313a7b733a31343a226d656e755f7461696c5f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, 0x613a313a7b693a323b733a31363a226d656e755f7461696c5f746f5f617267223b7d, '_search_menu_access', 0x613a313a7b693a303b733a343a2275736572223b7d, 'search_view', 0x613a323a7b693a303b733a343a2275736572223b693a313b693a323b7d, '', 6, 3, 1, 'search/node', 'search/node/%', 'Users', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('sites/default/files/styles/%', 0x613a313a7b693a343b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', '1', 0x613a303a7b7d, 'image_style_deliver', 0x613a313a7b693a303b693a343b7d, '', 30, 5, 0, '', 'sites/default/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/ajax', '', '', '1', 0x613a303a7b7d, 'ajax_form_callback', 0x613a303a7b7d, 'ajax_deliver', 3, 2, 0, '', 'system/ajax', 'AHAH callback', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'includes/form.inc'),
('system/files', '', '', '1', 0x613a303a7b7d, 'file_download', 0x613a313a7b693a303b733a373a2270726976617465223b7d, '', 3, 2, 0, '', 'system/files', 'File download', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/files/styles/%', 0x613a313a7b693a333b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', '1', 0x613a303a7b7d, 'image_style_deliver', 0x613a313a7b693a303b693a333b7d, '', 14, 4, 0, '', 'system/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/temporary', '', '', '1', 0x613a303a7b7d, 'file_download', 0x613a313a7b693a303b733a393a2274656d706f72617279223b7d, '', 3, 2, 0, '', 'system/temporary', 'Temporary files', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/timezone', '', '', '1', 0x613a303a7b7d, 'system_timezone', 0x613a303a7b7d, '', 3, 2, 0, '', 'system/timezone', 'Time zone', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc');
INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('taxonomy/autocomplete', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_autocomplete', 0x613a303a7b7d, '', 3, 2, 0, '', 'taxonomy/autocomplete', 'Autocomplete taxonomy', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_page', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'taxonomy/term/%', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', 6, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%/edit', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'taxonomy_term_edit_access', 0x613a313a7b693a303b693a323b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31383a227461786f6e6f6d795f666f726d5f7465726d223b693a313b693a323b693a323b4e3b7d, '', 13, 4, 1, 'taxonomy/term/%', 'taxonomy/term/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/taxonomy/taxonomy.admin.inc'),
('taxonomy/term/%/feed', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_feed', 0x613a313a7b693a303b693a323b7d, '', 13, 4, 0, '', 'taxonomy/term/%/feed', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', 0, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%/view', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_page', 0x613a313a7b693a303b693a323b7d, '', 13, 4, 1, 'taxonomy/term/%', 'taxonomy/term/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('user', '', '', '1', 0x613a303a7b7d, 'user_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'user', 'User account', 'user_menu_title', '', '', 'a:0:{}', 6, '', '', -10, 'modules/user/user.pages.inc'),
('user/%', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_view_access', 0x613a313a7b693a303b693a313b7d, 'user_view_page', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'user/%', 'My account', 'user_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', 6, '', '', 0, ''),
('user/%/cancel', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_cancel_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a22757365725f63616e63656c5f636f6e6669726d5f666f726d223b693a313b693a313b7d, '', 5, 3, 0, '', 'user/%/cancel', 'Cancel account', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/cancel/confirm/%/%', 0x613a333a7b693a313b733a393a22757365725f6c6f6164223b693a343b4e3b693a353b4e3b7d, '', 'user_cancel_access', 0x613a313a7b693a303b693a313b7d, 'user_cancel_confirm', 0x613a333a7b693a303b693a313b693a313b693a343b693a323b693a353b7d, '', 44, 6, 0, '', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/edit', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_edit_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a22757365725f70726f66696c655f666f726d223b693a313b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/edit/account', 0x613a313a7b693a313b613a313a7b733a31383a22757365725f63617465676f72795f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, '', 'user_edit_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a22757365725f70726f66696c655f666f726d223b693a313b693a313b7d, '', 11, 4, 1, 'user/%/edit', 'user/%', 'Account', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/edit/name_and_address', 0x613a313a7b693a313b613a313a7b733a31383a22757365725f63617465676f72795f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, '', '_civicrm_categories_access', 0x613a313a7b693a303b733a313a2231223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31373a22757365725f70726f66696c655f666f726d223b693a313b693a313b693a323b693a333b7d, '', 11, 4, 1, 'user/%/edit', 'user/%', '', 'civicrm_profile_title_callback', 'a:2:{i:0;s:1:"1";i:1;s:16:"Name and Address";}', '', 'a:0:{}', 132, '', '', 100, 'modules/user/user.pages.inc'),
('user/%/shortcuts', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'shortcut_set_switch_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31393a2273686f72746375745f7365745f737769746368223b693a313b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'Shortcuts', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('user/%/view', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_view_access', 0x613a313a7b693a303b693a313b7d, 'user_view_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('user/autocomplete', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261636365737320757365722070726f66696c6573223b7d, 'user_autocomplete', 0x613a303a7b7d, '', 3, 2, 0, '', 'user/autocomplete', 'User autocomplete', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/user/user.pages.inc'),
('user/login', '', '', 'user_is_anonymous', 0x613a303a7b7d, 'user_page', 0x613a303a7b7d, '', 3, 2, 1, 'user', 'user', 'Log in', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/user/user.pages.inc'),
('user/logout', '', '', 'user_is_logged_in', 0x613a303a7b7d, 'user_logout', 0x613a303a7b7d, '', 3, 2, 0, '', 'user/logout', 'Log out', 't', '', '', 'a:0:{}', 6, '', '', 10, 'modules/user/user.pages.inc'),
('user/password', '', '', '1', 0x613a303a7b7d, 'drupal_get_form', 0x613a313a7b693a303b733a393a22757365725f70617373223b7d, '', 3, 2, 1, 'user', 'user', 'Request new password', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/user/user.pages.inc'),
('user/register', '', '', 'user_register_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a22757365725f72656769737465725f666f726d223b7d, '', 3, 2, 1, 'user', 'user', 'Create new account', 't', '', '', 'a:0:{}', 132, '', '', 0, ''),
('user/reset/%/%/%', 0x613a333a7b693a323b4e3b693a333b4e3b693a343b4e3b7d, '', '1', 0x613a303a7b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31353a22757365725f706173735f7265736574223b693a313b693a323b693a323b693a333b693a333b693a343b7d, '', 24, 5, 0, '', 'user/reset/%/%/%', 'Reset password', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/user/user.pages.inc');

-- --------------------------------------------------------

--
-- Table structure for table `node`
--

CREATE TABLE `node` (
  `nid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for a node.',
  `vid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';

-- --------------------------------------------------------

--
-- Table structure for table `node_access`
--

CREATE TABLE `node_access` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';

--
-- Dumping data for table `node_access`
--

INSERT INTO `node_access` (`nid`, `gid`, `realm`, `grant_view`, `grant_update`, `grant_delete`) VALUES
(0, 0, 'all', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `node_comment_statistics`
--

CREATE TABLE `node_comment_statistics` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';

-- --------------------------------------------------------

--
-- Table structure for table `node_revision`
--

CREATE TABLE `node_revision` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';

-- --------------------------------------------------------

--
-- Table structure for table `node_type`
--

CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) UNSIGNED NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';

--
-- Dumping data for table `node_type`
--

INSERT INTO `node_type` (`type`, `name`, `base`, `module`, `description`, `help`, `has_title`, `title_label`, `custom`, `modified`, `locked`, `disabled`, `orig_type`) VALUES
('article', 'Article', 'node_content', 'node', 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', 1, 'Title', 1, 1, 0, 0, 'article'),
('page', 'Basic page', 'node_content', 'node', 'Use <em>basic pages</em> for your static content, such as an \'About us\' page.', '', 1, 'Title', 1, 1, 0, 0, 'page');

-- --------------------------------------------------------

--
-- Table structure for table `og_membership`
--

CREATE TABLE `og_membership` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'The group membership’s unique ID.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'Reference to a group membership type.',
  `etid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The entity ID.',
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The entity type (e.g. node, comment, etc’).',
  `gid` int(11) NOT NULL COMMENT 'The group’s unique ID.',
  `group_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The group’s entity type (e.g. node, comment, etc’).',
  `state` varchar(255) DEFAULT '' COMMENT 'The state of the group content.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the group content was created.',
  `field_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the field holding the group ID, the OG memebership is associated with.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this membership.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The group membership table.';

-- --------------------------------------------------------

--
-- Table structure for table `og_membership_type`
--

CREATE TABLE `og_membership_type` (
  `id` int(11) NOT NULL COMMENT 'Primary Key: Numeric group membership type ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The unified identifier for a group membership type.',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Description for this group membership type.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this membership type.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The group membership type.';

--
-- Dumping data for table `og_membership_type`
--

INSERT INTO `og_membership_type` (`id`, `name`, `description`, `status`, `module`, `language`) VALUES
(1, 'og_membership_type_default', 'Default', 2, 'og', '');

-- --------------------------------------------------------

--
-- Table structure for table `og_role`
--

CREATE TABLE `og_role` (
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique role ID.',
  `gid` int(11) NOT NULL COMMENT 'The group’s unique ID.',
  `group_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The group’s entity type.',
  `group_bundle` varchar(255) NOT NULL DEFAULT '' COMMENT 'The group’s bundle name.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name per group.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user roles per group.';

-- --------------------------------------------------------

--
-- Table structure for table `og_role_permission`
--

CREATE TABLE `og_role_permission` (
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles per group.';

-- --------------------------------------------------------

--
-- Table structure for table `og_users_roles`
--

CREATE TABLE `og_users_roles` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: og_role.rid for role.',
  `gid` int(11) NOT NULL COMMENT 'The group’s unique ID.',
  `group_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The group’s entity type.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';

-- --------------------------------------------------------

--
-- Table structure for table `queue`
--

CREATE TABLE `queue` (
  `item_id` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';

--
-- Dumping data for table `queue`
--

INSERT INTO `queue` (`item_id`, `name`, `data`, `expire`, `created`) VALUES
(11, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a373a226369766963726d223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a373a224369766943524d223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a373a227061636b616765223b733a373a224369766943524d223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313437373131303637353b733a393a22646174657374616d70223b693a303b7d733a393a22646174657374616d70223b693a303b733a383a22696e636c75646573223b613a323a7b733a373a226369766963726d223b733a373a224369766943524d223b733a31323a226369766963726d7468656d65223b733a31333a224369766943524d205468656d65223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1477121644);

-- --------------------------------------------------------

--
-- Table structure for table `rdf_mapping`
--

CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';

--
-- Dumping data for table `rdf_mapping`
--

INSERT INTO `rdf_mapping` (`type`, `bundle`, `mapping`) VALUES
('node', 'article', 0x613a31313a7b733a31313a226669656c645f696d616765223b613a323a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a383a226f673a696d616765223b693a313b733a31323a22726466733a736565416c736f223b7d733a343a2274797065223b733a333a2272656c223b7d733a31303a226669656c645f74616773223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31303a2264633a7375626a656374223b7d733a343a2274797065223b733a333a2272656c223b7d733a373a2272646674797065223b613a323a7b693a303b733a393a2273696f633a4974656d223b693a313b733a31333a22666f61663a446f63756d656e74223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d),
('node', 'page', 0x613a393a7b733a373a2272646674797065223b613a313a7b693a303b733a31333a22666f61663a446f63756d656e74223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d);

-- --------------------------------------------------------

--
-- Table structure for table `registry`
--

CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';

--
-- Dumping data for table `registry`
--

INSERT INTO `registry` (`name`, `type`, `filename`, `module`, `weight`) VALUES
('AccessDeniedTestCase', 'class', 'modules/system/system.test', 'system', 0),
('AdminMenuCustomizedTestCase', 'class', 'sites/all/modules/admin_menu/tests/admin_menu.test', 'admin_menu', 0),
('AdminMenuDynamicLinksTestCase', 'class', 'sites/all/modules/admin_menu/tests/admin_menu.test', 'admin_menu', 0),
('AdminMenuLinkTypesTestCase', 'class', 'sites/all/modules/admin_menu/tests/admin_menu.test', 'admin_menu', 0),
('AdminMenuPermissionsTestCase', 'class', 'sites/all/modules/admin_menu/tests/admin_menu.test', 'admin_menu', 0),
('AdminMenuWebTestCase', 'class', 'sites/all/modules/admin_menu/tests/admin_menu.test', 'admin_menu', 0),
('AdminMetaTagTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ArchiverInterface', 'interface', 'includes/archiver.inc', '', 0),
('ArchiverTar', 'class', 'modules/system/system.archiver.inc', 'system', 0),
('ArchiverZip', 'class', 'modules/system/system.archiver.inc', 'system', 0),
('Archive_Tar', 'class', 'modules/system/system.tar.inc', 'system', 0),
('BatchMemoryQueue', 'class', 'includes/batch.queue.inc', '', 0),
('BatchQueue', 'class', 'includes/batch.queue.inc', '', 0),
('BlockAdminThemeTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockCacheTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockHashTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockHiddenRegionTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockHTMLIdTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockInvalidRegionTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockTemplateSuggestionsUnitTest', 'class', 'modules/block/block.test', 'block', 0),
('BlockTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockViewModuleDeltaAlterWebTest', 'class', 'modules/block/block.test', 'block', 0),
('calendar_plugin_row_civicrm', 'class', 'sites/all/modules/civicrm/drupal/modules/views/plugins/calendar_plugin_row_civicrm.inc', 'civicrm', 0),
('calendar_plugin_row_civicrm_event', 'class', 'sites/all/modules/civicrm/drupal/modules/views/plugins/calendar_plugin_row_civicrm_event.inc', 'civicrm', 0),
('civicrm_handler_field', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field.inc', 'civicrm', 0),
('civicrm_handler_field_activity', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_activity.inc', 'civicrm', 0),
('civicrm_handler_field_address', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_address.inc', 'civicrm', 0),
('civicrm_handler_field_component', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_component.inc', 'civicrm', 0),
('civicrm_handler_field_contact_image', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_contact_image.inc', 'civicrm', 0),
('civicrm_handler_field_contact_link', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_contact_link.inc', 'civicrm', 0),
('civicrm_handler_field_country', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_country.inc', 'civicrm', 0),
('civicrm_handler_field_county', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_county.inc', 'civicrm', 0),
('civicrm_handler_field_custom', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_custom.inc', 'civicrm', 0),
('civicrm_handler_field_custom_file', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_custom_file.inc', 'civicrm', 0),
('civicrm_handler_field_datetime', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_datetime.inc', 'civicrm', 0),
('civicrm_handler_field_drupalid', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_drupalid.inc', 'civicrm', 0),
('civicrm_handler_field_email', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_email.inc', 'civicrm', 0),
('civicrm_handler_field_encounter_medium', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_encounter_medium.inc', 'civicrm', 0),
('civicrm_handler_field_event', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_event.inc', 'civicrm', 0),
('civicrm_handler_field_event_link', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_event_link.inc', 'civicrm', 0),
('civicrm_handler_field_link', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link.inc', 'civicrm', 0),
('civicrm_handler_field_link_activity', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_activity.inc', 'civicrm', 0),
('civicrm_handler_field_link_contact', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_contact.inc', 'civicrm', 0),
('civicrm_handler_field_link_contribution', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_contribution.inc', 'civicrm', 0),
('civicrm_handler_field_link_delete', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_delete.inc', 'civicrm', 0),
('civicrm_handler_field_link_edit', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_edit.inc', 'civicrm', 0),
('civicrm_handler_field_link_event', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_event.inc', 'civicrm', 0),
('civicrm_handler_field_link_participant', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_participant.inc', 'civicrm', 0),
('civicrm_handler_field_link_pcp', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_pcp.inc', 'civicrm', 0),
('civicrm_handler_field_link_relationship', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_relationship.inc', 'civicrm', 0),
('civicrm_handler_field_location', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_location.inc', 'civicrm', 0),
('civicrm_handler_field_mail', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_mail.inc', 'civicrm', 0),
('civicrm_handler_field_markup', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_markup.inc', 'civicrm', 0),
('civicrm_handler_field_money', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_money.inc', 'civicrm', 0),
('civicrm_handler_field_option', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_option.inc', 'civicrm', 0),
('civicrm_handler_field_pcp_raised_amount', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_pcp_raised_amount.inc', 'civicrm', 0),
('civicrm_handler_field_phone', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_phone.inc', 'civicrm', 0),
('civicrm_handler_field_pseudo_constant', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_pseudo_constant.inc', 'civicrm', 0),
('civicrm_handler_field_relationship_type', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_relationship_type.inc', 'civicrm', 0),
('civicrm_handler_field_state', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_state.inc', 'civicrm', 0),
('civicrm_handler_filter_country_multi', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_country_multi.inc', 'civicrm', 0),
('civicrm_handler_filter_custom_option', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_custom_option.inc', 'civicrm', 0),
('civicrm_handler_filter_custom_single_option', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_custom_single_option.inc', 'civicrm', 0),
('civicrm_handler_filter_datetime', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_datetime.inc', 'civicrm', 0),
('civicrm_handler_filter_domain', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_domain.inc', 'civicrm', 0),
('civicrm_handler_filter_encounter_medium', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_encounter_medium.inc', 'civicrm', 0),
('civicrm_handler_filter_group_status', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_group_status.inc', 'civicrm', 0),
('civicrm_handler_filter_pseudo_constant', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_pseudo_constant.inc', 'civicrm', 0),
('civicrm_handler_filter_relationship_type', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_relationship_type.inc', 'civicrm', 0),
('civicrm_handler_filter_state_multi', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_state_multi.inc', 'civicrm', 0),
('civicrm_handler_relationship', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_relationship.inc', 'civicrm', 0),
('civicrm_handler_relationship_contact2users', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_relationship_contact2users.inc', 'civicrm', 0),
('civicrm_handler_relationship_relationship', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_relationship_relationship.inc', 'civicrm', 0),
('civicrm_handler_sort_date', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_sort_date.inc', 'civicrm', 0),
('civicrm_handler_sort_pcp_raised_amount', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_sort_pcp_raised_amount.inc', 'civicrm', 0),
('civicrm_plugin_argument_default', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_plugin_argument_default.inc', 'civicrm', 0),
('civicrm_plugin_argument_default_civicrm_id', 'class', 'sites/all/modules/civicrm/drupal/modules/views/plugins/civicrm_plugin_argument_default_civicrm_id.inc', 'civicrm', 0),
('ColorTestCase', 'class', 'modules/color/color.test', 'color', 0),
('CommentActionsTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentAnonymous', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentApprovalTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentBlockFunctionalTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentContentRebuild', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentController', 'class', 'modules/comment/comment.module', 'comment', 0),
('CommentFieldsTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentHelperCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentInterfaceTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentNodeAccessTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentNodeChangesTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentPagerTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentPreviewTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentRSSUnitTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentThreadingTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentTokenReplaceTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('ConfirmFormTest', 'class', 'modules/system/system.test', 'system', 0),
('ContextualDynamicContextTestCase', 'class', 'modules/contextual/contextual.test', 'contextual', 0),
('CronQueueTestCase', 'class', 'modules/system/system.test', 'system', 0),
('CronRunTestCase', 'class', 'modules/system/system.test', 'system', 0),
('CToolsCssCache', 'class', 'sites/all/modules/ctools/includes/css-cache.inc', 'ctools', 0),
('CtoolsObjectCache', 'class', 'sites/all/modules/ctools/tests/css_cache.test', 'ctools', 0),
('ctools_context', 'class', 'sites/all/modules/ctools/includes/context.inc', 'ctools', 0),
('ctools_context_optional', 'class', 'sites/all/modules/ctools/includes/context.inc', 'ctools', 0),
('ctools_context_required', 'class', 'sites/all/modules/ctools/includes/context.inc', 'ctools', 0),
('ctools_export_ui', 'class', 'sites/all/modules/ctools/plugins/export_ui/ctools_export_ui.class.php', 'ctools', 0),
('ctools_math_expr', 'class', 'sites/all/modules/ctools/includes/math-expr.inc', 'ctools', 0),
('ctools_math_expr_stack', 'class', 'sites/all/modules/ctools/includes/math-expr.inc', 'ctools', 0),
('ctools_stylizer_image_processor', 'class', 'sites/all/modules/ctools/includes/stylizer.inc', 'ctools', 0),
('DashboardBlocksTestCase', 'class', 'modules/dashboard/dashboard.test', 'dashboard', 0),
('Database', 'class', 'includes/database/database.inc', '', 0),
('DatabaseCondition', 'class', 'includes/database/query.inc', '', 0),
('DatabaseConnection', 'class', 'includes/database/database.inc', '', 0),
('DatabaseConnectionNotDefinedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseConnection_mysql', 'class', 'includes/database/mysql/database.inc', '', 0),
('DatabaseConnection_pgsql', 'class', 'includes/database/pgsql/database.inc', '', 0),
('DatabaseConnection_sqlite', 'class', 'includes/database/sqlite/database.inc', '', 0),
('DatabaseDriverNotSpecifiedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseLog', 'class', 'includes/database/log.inc', '', 0),
('DatabaseSchema', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchemaObjectDoesNotExistException', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchemaObjectExistsException', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchema_mysql', 'class', 'includes/database/mysql/schema.inc', '', 0),
('DatabaseSchema_pgsql', 'class', 'includes/database/pgsql/schema.inc', '', 0),
('DatabaseSchema_sqlite', 'class', 'includes/database/sqlite/schema.inc', '', 0),
('DatabaseStatementBase', 'class', 'includes/database/database.inc', '', 0),
('DatabaseStatementEmpty', 'class', 'includes/database/database.inc', '', 0),
('DatabaseStatementInterface', 'interface', 'includes/database/database.inc', '', 0),
('DatabaseStatementPrefetch', 'class', 'includes/database/prefetch.inc', '', 0),
('DatabaseStatement_sqlite', 'class', 'includes/database/sqlite/database.inc', '', 0),
('DatabaseTaskException', 'class', 'includes/install.inc', '', 0),
('DatabaseTasks', 'class', 'includes/install.inc', '', 0),
('DatabaseTasks_mysql', 'class', 'includes/database/mysql/install.inc', '', 0),
('DatabaseTasks_pgsql', 'class', 'includes/database/pgsql/install.inc', '', 0),
('DatabaseTasks_sqlite', 'class', 'includes/database/sqlite/install.inc', '', 0),
('DatabaseTransaction', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionCommitFailedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionExplicitCommitNotAllowedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionNameNonUniqueException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionNoActiveException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionOutOfOrderException', 'class', 'includes/database/database.inc', '', 0),
('DateTimeFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('DBLogTestCase', 'class', 'modules/dblog/dblog.test', 'dblog', 0),
('DefaultMailSystem', 'class', 'modules/system/system.mail.inc', 'system', 0),
('DeleteQuery', 'class', 'includes/database/query.inc', '', 0),
('DeleteQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('DrupalCacheArray', 'class', 'includes/bootstrap.inc', '', 0),
('DrupalCacheInterface', 'interface', 'includes/cache.inc', '', 0),
('DrupalDatabaseCache', 'class', 'includes/cache.inc', '', 0),
('DrupalDefaultEntityController', 'class', 'includes/entity.inc', '', 0),
('DrupalEntityControllerInterface', 'interface', 'includes/entity.inc', '', 0),
('DrupalFakeCache', 'class', 'includes/cache-install.inc', '', 0),
('DrupalLocalStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalPrivateStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalPublicStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('DrupalQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', 0),
('DrupalReliableQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', 0),
('DrupalSetMessageTest', 'class', 'modules/system/system.test', 'system', 0),
('DrupalStreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', 0),
('DrupalTemporaryStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalUpdateException', 'class', 'includes/update.inc', '', 0),
('DrupalUpdaterInterface', 'interface', 'includes/updater.inc', '', 0),
('EnableDisableTestCase', 'class', 'modules/system/system.test', 'system', 0),
('Entity', 'class', 'sites/all/modules/entity/includes/entity.inc', 'entity', 0),
('EntityAPICommentNodeAccessTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityAPIController', 'class', 'sites/all/modules/entity/includes/entity.controller.inc', 'entity', 0),
('EntityAPIControllerExportable', 'class', 'sites/all/modules/entity/includes/entity.controller.inc', 'entity', 0),
('EntityAPIControllerInterface', 'interface', 'sites/all/modules/entity/includes/entity.controller.inc', 'entity', 0),
('EntityAPIControllerRevisionableInterface', 'interface', 'sites/all/modules/entity/includes/entity.controller.inc', 'entity', 0),
('EntityAPIi18nItegrationTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityAPIRulesIntegrationTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityAPITestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityBundleableUIController', 'class', 'sites/all/modules/entity/includes/entity.ui.inc', 'entity', 0),
('EntityContentUIController', 'class', 'sites/all/modules/entity/includes/entity.ui.inc', 'entity', 0),
('EntityDB', 'class', 'sites/all/modules/entity/includes/entity.inc', 'entity', 0),
('EntityDBExtendable', 'class', 'sites/all/modules/entity/includes/entity.inc', 'entity', 0),
('EntityDefaultExtraFieldsController', 'class', 'sites/all/modules/entity/entity.info.inc', 'entity', 0),
('EntityDefaultFeaturesController', 'class', 'sites/all/modules/entity/entity.features.inc', 'entity', 0),
('EntityDefaultI18nStringController', 'class', 'sites/all/modules/entity/entity.i18n.inc', 'entity', 0),
('EntityDefaultMetadataController', 'class', 'sites/all/modules/entity/entity.info.inc', 'entity', 0),
('EntityDefaultRulesController', 'class', 'sites/all/modules/entity/entity.rules.inc', 'entity', 0),
('EntityDefaultUIController', 'class', 'sites/all/modules/entity/includes/entity.ui.inc', 'entity', 0),
('EntityDefaultViewsController', 'class', 'sites/all/modules/entity/views/entity.views.inc', 'entity', 0),
('EntityDrupalWrapper', 'class', 'sites/all/modules/entity/includes/entity.wrapper.inc', 'entity', 0),
('EntityExtendable', 'class', 'sites/all/modules/entity/includes/entity.inc', 'entity', 0),
('EntityExtraFieldsControllerInterface', 'interface', 'sites/all/modules/entity/entity.info.inc', 'entity', 0),
('EntityFieldHandlerHelper', 'class', 'sites/all/modules/entity/views/handlers/entity_views_field_handler_helper.inc', 'entity', 0),
('EntityFieldQuery', 'class', 'includes/entity.inc', '', 0),
('EntityFieldQueryException', 'class', 'includes/entity.inc', '', 0),
('EntityInterface', 'interface', 'sites/all/modules/entity/includes/entity.inc', 'entity', 0),
('EntityListWrapper', 'class', 'sites/all/modules/entity/includes/entity.wrapper.inc', 'entity', 0),
('EntityMalformedException', 'class', 'includes/entity.inc', '', 0),
('EntityMetadataArrayObject', 'class', 'sites/all/modules/entity/includes/entity.wrapper.inc', 'entity', 0),
('EntityMetadataIntegrationTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityMetadataNodeAccessTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityMetadataNodeCreateAccessTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityMetadataNodeRevisionAccessTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityMetadataTaxonomyAccessTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityMetadataTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityMetadataWrapper', 'class', 'sites/all/modules/entity/includes/entity.wrapper.inc', 'entity', 0),
('EntityMetadataWrapperException', 'class', 'sites/all/modules/entity/includes/entity.wrapper.inc', 'entity', 0),
('EntityMetadataWrapperIterator', 'class', 'sites/all/modules/entity/includes/entity.wrapper.inc', 'entity', 0),
('EntityPropertiesTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('EntityReferenceAdminTestCase', 'class', 'sites/all/modules/entityreference/tests/entityreference.admin.test', 'entityreference', 0),
('EntityReferenceBehavior_TaxonomyIndex', 'class', 'sites/all/modules/entityreference/plugins/behavior/EntityReferenceBehavior_TaxonomyIndex.class.php', 'entityreference', 0),
('EntityReferenceHandlersTestCase', 'class', 'sites/all/modules/entityreference/tests/entityreference.handlers.test', 'entityreference', 0),
('EntityReferenceTaxonomyTestCase', 'class', 'sites/all/modules/entityreference/tests/entityreference.taxonomy.test', 'entityreference', 0),
('EntityReference_BehaviorHandler', 'interface', 'sites/all/modules/entityreference/plugins/behavior/abstract.inc', 'entityreference', 0),
('EntityReference_BehaviorHandler_Abstract', 'class', 'sites/all/modules/entityreference/plugins/behavior/abstract.inc', 'entityreference', 0),
('EntityReference_BehaviorHandler_Broken', 'class', 'sites/all/modules/entityreference/plugins/behavior/abstract.inc', 'entityreference', 0),
('entityreference_plugin_display', 'class', 'sites/all/modules/entityreference/views/entityreference_plugin_display.inc', 'entityreference', 0),
('entityreference_plugin_row_fields', 'class', 'sites/all/modules/entityreference/views/entityreference_plugin_row_fields.inc', 'entityreference', 0),
('entityreference_plugin_style', 'class', 'sites/all/modules/entityreference/views/entityreference_plugin_style.inc', 'entityreference', 0),
('EntityReference_SelectionHandler', 'interface', 'sites/all/modules/entityreference/plugins/selection/abstract.inc', 'entityreference', 0),
('EntityReference_SelectionHandler_Broken', 'class', 'sites/all/modules/entityreference/plugins/selection/abstract.inc', 'entityreference', 0),
('EntityReference_SelectionHandler_Generic', 'class', 'sites/all/modules/entityreference/plugins/selection/EntityReference_SelectionHandler_Generic.class.php', 'entityreference', 0),
('EntityReference_SelectionHandler_Generic_comment', 'class', 'sites/all/modules/entityreference/plugins/selection/EntityReference_SelectionHandler_Generic.class.php', 'entityreference', 0),
('EntityReference_SelectionHandler_Generic_file', 'class', 'sites/all/modules/entityreference/plugins/selection/EntityReference_SelectionHandler_Generic.class.php', 'entityreference', 0),
('EntityReference_SelectionHandler_Generic_node', 'class', 'sites/all/modules/entityreference/plugins/selection/EntityReference_SelectionHandler_Generic.class.php', 'entityreference', 0),
('EntityReference_SelectionHandler_Generic_taxonomy_term', 'class', 'sites/all/modules/entityreference/plugins/selection/EntityReference_SelectionHandler_Generic.class.php', 'entityreference', 0),
('EntityReference_SelectionHandler_Generic_user', 'class', 'sites/all/modules/entityreference/plugins/selection/EntityReference_SelectionHandler_Generic.class.php', 'entityreference', 0),
('EntityStructureWrapper', 'class', 'sites/all/modules/entity/includes/entity.wrapper.inc', 'entity', 0),
('EntityTokenTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('EntityValueWrapper', 'class', 'sites/all/modules/entity/includes/entity.wrapper.inc', 'entity', 0),
('EntityWebTestCase', 'class', 'sites/all/modules/entity/entity.test', 'entity', 0),
('entity_views_handler_area_entity', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_area_entity.inc', 'entity', 0),
('entity_views_handler_field_boolean', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_boolean.inc', 'entity', 0),
('entity_views_handler_field_date', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_date.inc', 'entity', 0),
('entity_views_handler_field_duration', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_duration.inc', 'entity', 0),
('entity_views_handler_field_entity', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_entity.inc', 'entity', 0),
('entity_views_handler_field_field', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_field.inc', 'entity', 0),
('entity_views_handler_field_numeric', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_numeric.inc', 'entity', 0),
('entity_views_handler_field_options', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_options.inc', 'entity', 0),
('entity_views_handler_field_text', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_text.inc', 'entity', 0),
('entity_views_handler_field_uri', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_field_uri.inc', 'entity', 0),
('entity_views_handler_relationship', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_relationship.inc', 'entity', 0),
('entity_views_handler_relationship_by_bundle', 'class', 'sites/all/modules/entity/views/handlers/entity_views_handler_relationship_by_bundle.inc', 'entity', 0),
('entity_views_plugin_row_entity_view', 'class', 'sites/all/modules/entity/views/plugins/entity_views_plugin_row_entity_view.inc', 'entity', 0),
('FacesExtendable', 'class', 'sites/all/modules/rules/includes/faces.inc', 'rules', 0),
('FacesExtendableException', 'class', 'sites/all/modules/rules/includes/faces.inc', 'rules', 0),
('FacesExtender', 'class', 'sites/all/modules/rules/includes/faces.inc', 'rules', 0),
('FacesExtenderInterface', 'interface', 'sites/all/modules/rules/includes/faces.inc', 'rules', 0),
('FeedsMapperFieldTestCase', 'class', 'sites/all/modules/entityreference/tests/entityreference.feeds.test', 'entityreference', 0),
('FieldAttachOtherTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldAttachStorageTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldAttachTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldBulkDeleteTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldDisplayAPITestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldException', 'class', 'modules/field/field.module', 'field', 0),
('FieldFormTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldInfo', 'class', 'modules/field/field.info.class.inc', 'field', 0),
('FieldInfoTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldInstanceCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldsOverlapException', 'class', 'includes/database/database.inc', '', 0),
('FieldSqlStorageTestCase', 'class', 'modules/field/modules/field_sql_storage/field_sql_storage.test', 'field_sql_storage', 0),
('FieldTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldTranslationsTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldUIAlterTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUIManageDisplayTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUIManageFieldsTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUITestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUpdateForbiddenException', 'class', 'modules/field/field.module', 'field', 0),
('FieldValidationException', 'class', 'modules/field/field.attach.inc', 'field', 0),
('FileFieldAnonymousSubmission', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldDisplayTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldPathTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldRevisionTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldValidateTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldWidgetTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileManagedFileElementTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FilePrivateTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTaxonomyTermTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTokenReplaceTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTransfer', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferChmodInterface', 'interface', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferException', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferFTP', 'class', 'includes/filetransfer/ftp.inc', '', 0),
('FileTransferFTPExtension', 'class', 'includes/filetransfer/ftp.inc', '', 0),
('FileTransferLocal', 'class', 'includes/filetransfer/local.inc', '', 0),
('FileTransferSSH', 'class', 'includes/filetransfer/ssh.inc', '', 0),
('FilterAdminTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterCRUDTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterDefaultFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterDOMSerializeTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterFormatAccessTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterHooksTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterNoFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterSecurityTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterSettingsTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterUnitTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FloodFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('FrontPageTestCase', 'class', 'modules/system/system.test', 'system', 0),
('HelpTestCase', 'class', 'modules/help/help.test', 'help', 0),
('HookRequirementsTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ImageAdminStylesUnitTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageAdminUiTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageDimensionsScaleTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageDimensionsTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageEffectsUnitTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldDefaultImagesTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldDisplayTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldValidateTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageStyleFlushTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageStylesPathAndUrlTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageThemeFunctionWebTestCase', 'class', 'modules/image/image.test', 'image', 0),
('InfoFileParserTestCase', 'class', 'modules/system/system.test', 'system', 0),
('InsertQuery', 'class', 'includes/database/query.inc', '', 0),
('InsertQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', 0),
('InsertQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', 0),
('InsertQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('InvalidMergeQueryException', 'class', 'includes/database/database.inc', '', 0),
('IPAddressBlockingTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ListDynamicValuesTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListDynamicValuesValidationTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListFieldTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListFieldUITestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('MailSystemInterface', 'interface', 'includes/mail.inc', '', 0),
('MemoryQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('MenuNodeTestCase', 'class', 'modules/menu/menu.test', 'menu', 0),
('MenuTestCase', 'class', 'modules/menu/menu.test', 'menu', 0),
('MergeQuery', 'class', 'includes/database/query.inc', '', 0),
('MigrateDestinationOGMembership', 'class', 'sites/all/modules/og/includes/migrate/plugins/destinations/og_membership.inc', 'og', 0),
('MigrateEntityReferenceFieldHandler', 'class', 'sites/all/modules/entityreference/entityreference.migrate.inc', 'entityreference', 0),
('ModuleDependencyTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleRequiredTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleUpdater', 'class', 'modules/system/system.updater.inc', 'system', 0),
('ModuleVersionTestCase', 'class', 'modules/system/system.test', 'system', 0),
('MultiStepNodeFormBasicOptionsTest', 'class', 'modules/node/node.test', 'node', 0),
('NewDefaultThemeBlocks', 'class', 'modules/block/block.test', 'block', 0),
('NodeAccessBaseTableTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessFieldTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessPagerTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessRebuildTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessRecordsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAdminTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeBlockFunctionalTest', 'class', 'modules/node/node.test', 'node', 0),
('NodeBlockTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeBuildContent', 'class', 'modules/node/node.test', 'node', 0),
('NodeController', 'class', 'modules/node/node.module', 'node', 0),
('NodeCreationTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeEntityFieldQueryAlter', 'class', 'modules/node/node.test', 'node', 0),
('NodeEntityViewModeAlterTest', 'class', 'modules/node/node.test', 'node', 0),
('NodeFeedTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeLoadHooksTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeLoadMultipleTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeMultiByteUtf8Test', 'class', 'modules/node/node.test', 'node', 0),
('NodePageCacheTest', 'class', 'modules/node/node.test', 'node', 0),
('NodePostSettingsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeQueryAlter', 'class', 'modules/node/node.test', 'node', 0),
('NodeRevisionPermissionsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeRevisionsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeRSSContentTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeSaveTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTitleTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTitleXSSTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTokenReplaceTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTypePersistenceTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTypeTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeWebTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NoFieldsException', 'class', 'includes/database/database.inc', '', 0),
('NoHelpTestCase', 'class', 'modules/help/help.test', 'help', 0),
('NonDefaultBlockAdmin', 'class', 'modules/block/block.test', 'block', 0),
('NumberFieldTestCase', 'class', 'modules/field/modules/number/number.test', 'number', 0),
('OgAccess', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgAudienceFieldAccessOverrideTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgAudienceFieldAutoCreateTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgAudienceFieldDeltaTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgAutoCompleteAccessibleGroupsValidation', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgBehaviorHandler', 'class', 'sites/all/modules/og/plugins/entityreference/behavior/OgBehaviorHandler.class.php', 'og', 0),
('OgBehaviorHandlerTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgDefaultAccessFieldTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgDeleteOrphansTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgEntityFieldQueryFieldConditionTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgEntityFieldQueryTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgEntityMigration', 'class', 'sites/all/modules/og/includes/migrate/og.migrate.inc', 'og', 0),
('OgException', 'class', 'sites/all/modules/og/includes/og.exception.inc', 'og', 0),
('OgFieldWidgetTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgGroupAndUngroup', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgMembership', 'class', 'sites/all/modules/og/includes/og.membership.inc', 'og', 0),
('OgMembershipMetadataController', 'class', 'sites/all/modules/og/og.info.inc', 'og', 0),
('OgMembershipType', 'class', 'sites/all/modules/og/includes/og.membership_type.inc', 'og', 0),
('OgMembershipTypeUIController', 'class', 'sites/all/modules/og/includes/og.admin.inc', 'og', 0),
('OgMembershipViewsController', 'class', 'sites/all/modules/og/includes/views/og.views.inc', 'og', 0),
('OgMetaData', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgMigrate7000TestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgMigrate7200TestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgMigrateAddFields', 'class', 'sites/all/modules/og/includes/migrate/7000/og_add_fields.inc', 'og', 0),
('OgMigrateContent', 'class', 'sites/all/modules/og/includes/migrate/7000/og_content.inc', 'og', 0),
('OgMigrateGroup', 'class', 'sites/all/modules/og/includes/migrate/7000/og_group.inc', 'og', 0),
('OgMigrateMembership', 'class', 'sites/all/modules/og/includes/migrate/7200/og_og_membership.migrate.inc', 'og', 0),
('OgMigrateOgur', 'class', 'sites/all/modules/og/includes/migrate/7000/og_ogur.migrate.inc', 'og', 0),
('OgMigrateOgurRoles', 'class', 'sites/all/modules/og/includes/migrate/7000/og_ogur_roles.migrate.inc', 'og', 0),
('OgMigrateRoles', 'class', 'sites/all/modules/og/includes/migrate/7200/og_roles.migrate.inc', 'og', 0),
('OgMigrateUser', 'class', 'sites/all/modules/og/includes/migrate/7000/og_user.inc', 'og', 0),
('OgMigrateUserRoles', 'class', 'sites/all/modules/og/includes/migrate/7200/og_user_roles.migrate.inc', 'og', 0),
('OgNodeAccess', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgNonMembersPublishingContentTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgPermissionsTestCase', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgRoleRevoke', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgSelectAccessibleGroupsValidation', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgSelectionHandler', 'class', 'sites/all/modules/og/plugins/entityreference/selection/OgSelectionHandler.class.php', 'og', 0),
('OgUserCanPublishGroupContentTypeOnlyInGroup', 'class', 'sites/all/modules/og/og.test', 'og', 0),
('OgWidgetHandler', 'class', 'sites/all/modules/og/plugins/entityreference/behavior/OgWidgetHandler.class.php', 'og', 0),
('og_handler_field_group_audience_state', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_field_group_audience_state.inc', 'og', 0),
('og_handler_field_group_permissions', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_field_group_permissions.inc', 'og', 0),
('og_handler_field_og_membership_link_delete', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_field_og_membership_link_delete.inc', 'og', 0),
('og_handler_field_og_membership_link_edit', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_field_og_membership_link_edit.inc', 'og', 0),
('og_handler_field_prerender_list', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_field_prerender_list.inc', 'og', 0),
('og_handler_field_user_roles', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_field_user_roles.inc', 'og', 0),
('og_handler_filter_group_audience_state', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_filter_group_audience_state.inc', 'og', 0),
('og_handler_filter_user_roles', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_filter_user_roles.inc', 'og', 0),
('og_handler_relationship', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_relationship.inc', 'og', 0),
('og_handler_relationship_membership_roles', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_relationship_membership_roles.inc', 'og', 0),
('og_plugin_argument_default_user_groups', 'class', 'sites/all/modules/og/includes/views/handlers/og_plugin_argument_default_user_groups.inc', 'og', 0),
('og_plugin_argument_validate_group', 'class', 'sites/all/modules/og/includes/views/handlers/og_plugin_argument_validate_group.inc', 'og', 0),
('og_users_roles_join', 'class', 'sites/all/modules/og/includes/views/handlers/og_handler_relationship_membership_roles.inc', 'og', 0),
('OptionsSelectDynamicValuesTestCase', 'class', 'modules/field/modules/options/options.test', 'options', 0),
('OptionsWidgetsTestCase', 'class', 'modules/field/modules/options/options.test', 'options', 0),
('PageEditTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PageNotFoundTestCase', 'class', 'modules/system/system.test', 'system', 0),
('PagePreviewTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PagerDefault', 'class', 'includes/pager.inc', '', 0),
('PageTitleFiltering', 'class', 'modules/system/system.test', 'system', 0),
('PageViewTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PathLanguageTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathLanguageUITestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathMonolingualTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathTaxonomyTermTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathTestCase', 'class', 'modules/path/path.test', 'path', 0),
('Query', 'class', 'includes/database/query.inc', '', 0),
('QueryAlterableInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueryConditionInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueryExtendableInterface', 'interface', 'includes/database/select.inc', '', 0),
('QueryPlaceholderInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueueTestCase', 'class', 'modules/system/system.test', 'system', 0),
('RdfCommentAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfCrudTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfGetRdfNamespacesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfMappingDefinitionTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfMappingHookTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfRdfaMarkupTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfTrackerAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RetrieveFileTestCase', 'class', 'modules/system/system.test', 'system', 0),
('Rule', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesAbstractPlugin', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesAbstractPluginDefaults', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesAbstractPluginUI', 'class', 'sites/all/modules/rules/ui/ui.core.inc', 'rules', 0),
('RulesAction', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesActionContainer', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesActionContainerUI', 'class', 'sites/all/modules/rules/ui/ui.core.inc', 'rules', 0),
('RulesActionHandlerBase', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesActionHandlerInterface', 'interface', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesActionInterface', 'interface', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesActionSet', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesAnd', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesCondition', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesConditionContainer', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesConditionContainerUI', 'class', 'sites/all/modules/rules/ui/ui.core.inc', 'rules', 0),
('RulesConditionHandlerBase', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesConditionHandlerInterface', 'interface', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesConditionInterface', 'interface', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesContainerPlugin', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesContainerPluginUI', 'class', 'sites/all/modules/rules/ui/ui.core.inc', 'rules', 0),
('RulesData', 'class', 'sites/all/modules/rules/includes/rules.state.inc', 'rules', 0),
('RulesDataDirectInputFormInterface', 'interface', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataInputEvaluator', 'class', 'sites/all/modules/rules/includes/rules.processor.inc', 'rules', 0),
('RulesDataInputOptionsListInterface', 'interface', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataProcessor', 'class', 'sites/all/modules/rules/includes/rules.processor.inc', 'rules', 0),
('RulesDataUI', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIBoolean', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIBundleEntity', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIDate', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIDecimal', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIDuration', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIEntity', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIEntityExportable', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIInteger', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIIPAddress', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIListEntity', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIListInteger', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIListText', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIListToken', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUITaxonomyVocabulary', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIText', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUITextFormatted', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUITextToken', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataUIURI', 'class', 'sites/all/modules/rules/ui/ui.data.inc', 'rules', 0),
('RulesDataWrapperSavableInterface', 'interface', 'sites/all/modules/rules/includes/rules.state.inc', 'rules', 0),
('RulesDateInputEvaluator', 'class', 'sites/all/modules/rules/modules/rules_core.eval.inc', 'rules', 0),
('RulesDateOffsetProcessor', 'class', 'sites/all/modules/rules/modules/rules_core.eval.inc', 'rules', 0),
('RulesDependencyException', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesElementMap', 'class', 'sites/all/modules/rules/ui/ui.core.inc', 'rules', 0),
('RulesEntityController', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesEvaluationException', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesEventDefaultHandler', 'class', 'sites/all/modules/rules/includes/rules.event.inc', 'rules', 0),
('RulesEventDispatcherInterface', 'interface', 'sites/all/modules/rules/includes/rules.event.inc', 'rules', 0),
('RulesEventDispatcherTestCase', 'class', 'sites/all/modules/rules/tests/rules.test', 'rules', 0),
('RulesEventHandlerBase', 'class', 'sites/all/modules/rules/includes/rules.event.inc', 'rules', 0),
('RulesEventHandlerEntityBundle', 'class', 'sites/all/modules/rules/includes/rules.event.inc', 'rules', 0),
('RulesEventHandlerInterface', 'interface', 'sites/all/modules/rules/includes/rules.event.inc', 'rules', 0),
('RulesEventSet', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesException', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesExtendable', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesFeaturesController', 'class', 'sites/all/modules/rules/rules.features.inc', 'rules', 0),
('RulesIdentifiableDataWrapper', 'class', 'sites/all/modules/rules/includes/rules.state.inc', 'rules', 0),
('RulesIntegrationTestCase', 'class', 'sites/all/modules/rules/tests/rules.test', 'rules', 0),
('RulesIntegrityException', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesInvocationEnabledTestCase', 'class', 'sites/all/modules/rules/tests/rules.test', 'rules', 0);
INSERT INTO `registry` (`name`, `type`, `filename`, `module`, `weight`) VALUES
('RulesLog', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesLoop', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesLoopUI', 'class', 'sites/all/modules/rules/ui/ui.plugins.inc', 'rules', 0),
('RulesNodeConditionBase', 'class', 'sites/all/modules/rules/modules/node.eval.inc', 'rules', 0),
('RulesNodeConditionPromoted', 'class', 'sites/all/modules/rules/modules/node.eval.inc', 'rules', 0),
('RulesNodeConditionPublished', 'class', 'sites/all/modules/rules/modules/node.eval.inc', 'rules', 0),
('RulesNodeConditionSticky', 'class', 'sites/all/modules/rules/modules/node.eval.inc', 'rules', 0),
('RulesNodeConditionType', 'class', 'sites/all/modules/rules/modules/node.eval.inc', 'rules', 0),
('RulesNumericOffsetProcessor', 'class', 'sites/all/modules/rules/modules/rules_core.eval.inc', 'rules', 0),
('RulesOptimizationInterface', 'interface', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesOr', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesPHPDataProcessor', 'class', 'sites/all/modules/rules/modules/php.eval.inc', 'rules', 0),
('RulesPHPEvaluator', 'class', 'sites/all/modules/rules/modules/php.eval.inc', 'rules', 0),
('RulesPlugin', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesPluginFeaturesIntegrationInterace', 'interface', 'sites/all/modules/rules/rules.features.inc', 'rules', 0),
('RulesPluginHandlerBase', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesPluginHandlerInterface', 'interface', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesPluginImplInterface', 'interface', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesPluginUI', 'class', 'sites/all/modules/rules/ui/ui.core.inc', 'rules', 0),
('RulesPluginUIInterface', 'interface', 'sites/all/modules/rules/ui/ui.core.inc', 'rules', 0),
('RulesReactionRule', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesReactionRuleUI', 'class', 'sites/all/modules/rules/ui/ui.plugins.inc', 'rules', 0),
('RulesRecursiveElementIterator', 'class', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesRuleSet', 'class', 'sites/all/modules/rules/includes/rules.plugins.inc', 'rules', 0),
('RulesRuleSetUI', 'class', 'sites/all/modules/rules/ui/ui.plugins.inc', 'rules', 0),
('RulesRuleUI', 'class', 'sites/all/modules/rules/ui/ui.plugins.inc', 'rules', 0),
('RulesState', 'class', 'sites/all/modules/rules/includes/rules.state.inc', 'rules', 0),
('RulesTaxonomyVocabularyWrapper', 'class', 'sites/all/modules/rules/modules/rules_core.eval.inc', 'rules', 0),
('RulesTestCase', 'class', 'sites/all/modules/rules/tests/rules.test', 'rules', 0),
('RulesTestDataCase', 'class', 'sites/all/modules/rules/tests/rules.test', 'rules', 0),
('RulesTokenEvaluator', 'class', 'sites/all/modules/rules/modules/system.eval.inc', 'rules', 0),
('RulesTriggerableInterface', 'interface', 'sites/all/modules/rules/includes/rules.core.inc', 'rules', 0),
('RulesTriggerTestCase', 'class', 'sites/all/modules/rules/tests/rules.test', 'rules', 0),
('RulesUICategory', 'class', 'sites/all/modules/rules/ui/ui.core.inc', 'rules', 0),
('RulesUIController', 'class', 'sites/all/modules/rules/ui/ui.controller.inc', 'rules', 0),
('RulesURIInputEvaluator', 'class', 'sites/all/modules/rules/modules/rules_core.eval.inc', 'rules', 0),
('SchemaCache', 'class', 'includes/bootstrap.inc', '', 0),
('SearchAdvancedSearchForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchBlockTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchCommentCountToggleTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchCommentTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchConfigSettingsForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchEmbedForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchExactTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchExcerptTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchExpressionInsertExtractTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchKeywordsConditions', 'class', 'modules/search/search.test', 'search', 0),
('SearchLanguageTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchMatchTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchNodeAccessTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchNodeTagTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchNumberMatchingTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchNumbersTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchPageOverride', 'class', 'modules/search/search.test', 'search', 0),
('SearchPageText', 'class', 'modules/search/search.test', 'search', 0),
('SearchQuery', 'class', 'modules/search/search.extender.inc', 'search', 0),
('SearchRankingTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchSetLocaleTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchSimplifyTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchTokenizerTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SelectQuery', 'class', 'includes/database/select.inc', '', 0),
('SelectQueryExtender', 'class', 'includes/database/select.inc', '', 0),
('SelectQueryInterface', 'interface', 'includes/database/select.inc', '', 0),
('SelectQuery_pgsql', 'class', 'includes/database/pgsql/select.inc', '', 0),
('SelectQuery_sqlite', 'class', 'includes/database/sqlite/select.inc', '', 0),
('ShortcutLinksTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShortcutSetsTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShortcutTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShutdownFunctionsTest', 'class', 'modules/system/system.test', 'system', 0),
('SiteMaintenanceTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SkipDotsRecursiveDirectoryIterator', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('StreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', 0),
('SummaryLengthTestCase', 'class', 'modules/node/node.test', 'node', 0),
('SystemAdminTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemAuthorizeCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemBlockTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemIndexPhpTest', 'class', 'modules/system/system.test', 'system', 0),
('SystemInfoAlterTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemMainContentFallback', 'class', 'modules/system/system.test', 'system', 0),
('SystemQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('SystemThemeFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('SystemValidTokenTest', 'class', 'modules/system/system.test', 'system', 0),
('TableSort', 'class', 'includes/tablesort.inc', '', 0),
('TaxonomyEFQTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyHooksTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyLegacyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyLoadMultipleTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyRSSTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', 0),
('TaxonomyTermFieldMultipleVocabularyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermFieldTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermFunctionTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermIndexTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyThemeTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTokenReplaceTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyVocabularyController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', 0),
('TaxonomyVocabularyFunctionalTest', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyVocabularyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyWebTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TestingMailSystem', 'class', 'modules/system/system.mail.inc', 'system', 0),
('TextFieldTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('TextSummaryTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('TextTranslationTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('ThemeRegistry', 'class', 'includes/theme.inc', '', 0),
('ThemeUpdater', 'class', 'modules/system/system.updater.inc', 'system', 0),
('TokenReplaceTestCase', 'class', 'modules/system/system.test', 'system', 0),
('TokenScanTest', 'class', 'modules/system/system.test', 'system', 0),
('TruncateQuery', 'class', 'includes/database/query.inc', '', 0),
('TruncateQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', 0),
('TruncateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('UpdateCoreTestCase', 'class', 'modules/update/update.test', 'update', 0),
('UpdateCoreUnitTestCase', 'class', 'modules/update/update.test', 'update', 0),
('UpdateQuery', 'class', 'includes/database/query.inc', '', 0),
('UpdateQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', 0),
('UpdateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('Updater', 'class', 'includes/updater.inc', '', 0),
('UpdaterException', 'class', 'includes/updater.inc', '', 0),
('UpdaterFileTransferException', 'class', 'includes/updater.inc', '', 0),
('UpdateScriptFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('UpdateTestContribCase', 'class', 'modules/update/update.test', 'update', 0),
('UpdateTestHelper', 'class', 'modules/update/update.test', 'update', 0),
('UpdateTestUploadCase', 'class', 'modules/update/update.test', 'update', 0),
('UserAccountLinksUnitTests', 'class', 'modules/user/user.test', 'user', 0),
('UserAdminTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserAuthmapAssignmentTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserAutocompleteTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserBlocksUnitTests', 'class', 'modules/user/user.test', 'user', 0),
('UserCancelTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserController', 'class', 'modules/user/user.module', 'user', 0),
('UserCreateTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserEditedOwnAccountTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserEditRebuildTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserEditTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserLoginTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPasswordResetTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPermissionsTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPictureTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRegistrationTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRoleAdminTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRolesAssignmentTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserSaveTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserSignatureTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserTimeZoneFunctionalTest', 'class', 'modules/user/user.test', 'user', 0),
('UserTokenReplaceTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserUserSearchTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserValidateCurrentPassCustomForm', 'class', 'modules/user/user.test', 'user', 0),
('UserValidationTestCase', 'class', 'modules/user/user.test', 'user', 0),
('views_handler_argument_civicrm_day', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_day.inc', 'civicrm', 0),
('views_handler_argument_civicrm_fulldate', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_fulldate.inc', 'civicrm', 0),
('views_handler_argument_civicrm_month', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_month.inc', 'civicrm', 0),
('views_handler_argument_civicrm_week', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_week.inc', 'civicrm', 0),
('views_handler_argument_civicrm_year', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_year.inc', 'civicrm', 0),
('views_handler_argument_civicrm_year_month', 'class', 'sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_year_month.inc', 'civicrm', 0);

-- --------------------------------------------------------

--
-- Table structure for table `registry_file`
--

CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';

--
-- Dumping data for table `registry_file`
--

INSERT INTO `registry_file` (`filename`, `hash`) VALUES
('includes/actions.inc', 'f36b066681463c7dfe189e0430cb1a89bf66f7e228cbb53cdfcd93987193f759'),
('includes/ajax.inc', '3d1c0d2efcdab327224122df1156a665f9bbf60873907dde2f189b018d4e9be3'),
('includes/archiver.inc', 'bdbb21b712a62f6b913590b609fd17cd9f3c3b77c0d21f68e71a78427ed2e3e9'),
('includes/authorize.inc', '6d64d8c21aa01eb12fc29918732e4df6b871ed06e5d41373cb95c197ed661d13'),
('includes/batch.inc', '1fe00f9a25481cd43e19fbd6bd37b7ff9dca79f8405ec3e55ffb011be12ec2c3'),
('includes/batch.queue.inc', '554b2e92e1dad0f7fd5a19cb8dff7e109f10fbe2441a5692d076338ec908de0f'),
('includes/bootstrap.inc', '597f870b128d053c8dba62684d0cece6bc262e111c4acb0510deddf6a8297adf'),
('includes/cache-install.inc', 'e7ed123c5805703c84ad2cce9c1ca46b3ce8caeeea0d8ef39a3024a4ab95fa0e'),
('includes/cache.inc', 'ee0bf13c7e067695dffcb9ade3b79fea82a3a8db9e9a422ebfcc91c383aa4b4c'),
('includes/common.inc', '8238bc141c9fdb6e017d5dab28d5c3da8f442d9e7bc444f0a106bee25c2992f0'),
('includes/database/database.inc', '2ef46543fb9cf61ed9fa9aed4e44dd31630c22604ea6b8e48b57ebd7ad11a111'),
('includes/database/log.inc', '9feb5a17ae2fabcf26a96d2a634ba73da501f7bcfc3599a693d916a6971d00d1'),
('includes/database/mysql/database.inc', '32a577354dba6030043500873f8a2a7359c80c179a213284b026c1a9b0452b70'),
('includes/database/mysql/install.inc', '6ae316941f771732fbbabed7e1d6b4cbb41b1f429dd097d04b3345aa15e461a0'),
('includes/database/mysql/query.inc', '0212a871646c223bf77aa26b945c77a8974855373967b5fb9fdc09f8a1de88a6'),
('includes/database/mysql/schema.inc', '2ef729f8d6466d5cd87ba233152d88590bce629d8366040b2509b4e24258d780'),
('includes/database/pgsql/database.inc', '8bb1a65c8dcc9ab145a68c69677ee6bf897b8d176344b500c6c8e07f6a81033f'),
('includes/database/pgsql/install.inc', '585b80c5bbd6f134bff60d06397f15154657a577d4da8d1b181858905f09dea5'),
('includes/database/pgsql/query.inc', '0df57377686c921e722a10b49d5e433b131176c8059a4ace4680964206fc14b4'),
('includes/database/pgsql/schema.inc', '1588daadfa53506aa1f5d94572162a45a46dc3ceabdd0e2f224532ded6508403'),
('includes/database/pgsql/select.inc', 'fd4bba7887c1dc6abc8f080fc3a76c01d92ea085434e355dc1ecb50d8743c22d'),
('includes/database/prefetch.inc', 'b5b207a66a69ecb52ee4f4459af16a7b5eabedc87254245f37cc33bebb61c0fb'),
('includes/database/query.inc', '4016a397f10f071cac338fd0a9b004296106e42ab2b9db8c7ff0db341658e88f'),
('includes/database/schema.inc', '9fecfd13fc1d4056a62d385840dccd052ea0e184dc47101f4bd8f57f10b68174'),
('includes/database/select.inc', '5e9cdc383564ba86cb9dcad0046990ce15415a3000e4f617d6e0f30a205b852c'),
('includes/database/sqlite/database.inc', '62f6669c4610557c4b34ada9f0a0f61d6cb7b377e0a9032d2efca7b5f39b0965'),
('includes/database/sqlite/install.inc', '6620f354aa175a116ba3a0562c980d86cc3b8b481042fc3cc5ed6a4d1a7a6d74'),
('includes/database/sqlite/query.inc', 'f33ab1b6350736a231a4f3f93012d3aac4431ac4e5510fb3a015a5aa6cab8303'),
('includes/database/sqlite/schema.inc', 'cd829700205a8574f8b9d88cd1eaf909519c64754c6f84d6c62b5d21f5886f8d'),
('includes/database/sqlite/select.inc', '8d1c426dbd337733c206cce9f59a172546c6ed856d8ef3f1c7bef05a16f7bf68'),
('includes/date.inc', '18c047be64f201e16d189f1cc47ed9dcf0a145151b1ee187e90511b24e5d2b36'),
('includes/entity.inc', 'f06b508f93e72ba70f979d8391be57662c018a03a32fac0a6d3baa752740133d'),
('includes/errors.inc', '2ced35723e95483694205a55c8ee29498cc8ae162e0c345288ea174c9dcf1ff7'),
('includes/file.inc', 'b5374e98eb062566e8993da228692c77c3ddb4350714b542282846f33608bac3'),
('includes/file.mimetypes.inc', '33266e837f4ce076378e7e8cef6c5af46446226ca4259f83e13f605856a7f147'),
('includes/filetransfer/filetransfer.inc', 'fdea8ae48345ec91885ac48a9bc53daf87616271472bb7c29b7e3ce219b22034'),
('includes/filetransfer/ftp.inc', '51eb119b8e1221d598ffa6cc46c8a322aa77b49a3d8879f7fb38b7221cf7e06d'),
('includes/filetransfer/local.inc', '7cbfdb46abbdf539640db27e66fb30e5265128f31002bd0dfc3af16ae01a9492'),
('includes/filetransfer/ssh.inc', '92f1232158cb32ab04cbc93ae38ad3af04796e18f66910a9bc5ca8e437f06891'),
('includes/form.inc', '3b2bb9088e75d72082ffd008fedcaf08432c14ad238c96d96a2ccc58b8caf107'),
('includes/graph.inc', '8e0e313a8bb33488f371df11fc1b58d7cf80099b886cd1003871e2c896d1b536'),
('includes/image.inc', 'bcdc7e1599c02227502b9d0fe36eeb2b529b130a392bc709eb737647bd361826'),
('includes/install.core.inc', '189653e4bb7d4828bd6e1b61015fabcc7182e23d9dd8858170f98114d99400c8'),
('includes/install.inc', 'fbb23627b06abb070b4531da786c1e06bf1dbd6f923bb2b404f4808c2340b0f9'),
('includes/iso.inc', '0ce4c225edcfa9f037703bc7dd09d4e268a69bcc90e55da0a3f04c502bd2f349'),
('includes/json-encode.inc', '02a822a652d00151f79db9aa9e171c310b69b93a12f549bc2ce00533a8efa14e'),
('includes/language.inc', '4e08f30843a7ccaeea5c041083e9f77d33d57ff002f1ab4f66168e2c683ce128'),
('includes/locale.inc', 'ca50acc0780cbffeca17f99a0997f91b8b9402f0eec1898c3122e1d73664d01d'),
('includes/lock.inc', 'a181c8bd4f88d292a0a73b9f1fbd727e3314f66ec3631f288e6b9a54ba2b70fa'),
('includes/mail.inc', '41d0e657119a05f8d7e85ebf32e74b12a1c3107d717a348158414b113e208b9c'),
('includes/menu.inc', 'c24d3ed92d05cbabfa4d950e67165e09b65c42a0ae90398cb5b039949be12c87'),
('includes/module.inc', '8dab73e50e6bcd680a26f55597d2d103ba68a29089f888e2a2c206fc38eaa669'),
('includes/pager.inc', '6f9494b85c07a2cc3be4e54aff2d2757485238c476a7da084d25bde1d88be6d8'),
('includes/password.inc', 'fd9a1c94fe5a0fa7c7049a2435c7280b1d666b2074595010e3c492dd15712775'),
('includes/path.inc', '2dca08d14a46e5ac6a665b7a5dde78045d8de2b35aaa78c6fb811e1125ce4953'),
('includes/registry.inc', 'f47b20859f0fc80bf4bb2849a1282d6c54006957b69da0e5f4691de585ca4cdf'),
('includes/session.inc', '5851ff6941aba2744dd0c247f077fc02fbbe24e9786e04ea0a3c372d68ca6d16'),
('includes/stream_wrappers.inc', '4f1feb774a8dbc04ca382fa052f59e58039c7261625f3df29987d6b31f08d92d'),
('includes/tablesort.inc', '2d88768a544829595dd6cda2a5eb008bedb730f36bba6dfe005d9ddd999d5c0f'),
('includes/theme.inc', '5d8b96db9760367eb86821085a17a144a58cb355e6f547e321321ee34535da7b'),
('includes/theme.maintenance.inc', '39f068b3eee4d10a90d6aa3c86db587b6d25844c2919d418d34d133cfe330f5a'),
('includes/token.inc', '5e7898cd78689e2c291ed3cd8f41c032075656896f1db57e49217aac19ae0428'),
('includes/unicode.entities.inc', '2b858138596d961fbaa4c6e3986e409921df7f76b6ee1b109c4af5970f1e0f54'),
('includes/unicode.inc', 'e18772dafe0f80eb139fcfc582fef1704ba9f730647057d4f4841d6a6e4066ca'),
('includes/update.inc', '25c30f1e61ef9c91a7bdeb37791c2215d9dc2ae07dba124722d783ca31bb01e7'),
('includes/updater.inc', 'd2da0e74ed86e93c209f16069f3d32e1a134ceb6c06a0044f78e841a1b54e380'),
('includes/utility.inc', '3458fd2b55ab004dd0cc529b8e58af12916e8bd36653b072bdd820b26b907ed5'),
('includes/xmlrpc.inc', 'ea24176ec445c440ba0c825fc7b04a31b440288df8ef02081560dc418e34e659'),
('includes/xmlrpcs.inc', '925c4d5bf429ad9650f059a8862a100bd394dce887933f5b3e7e32309a51fd8e'),
('modules/block/block.test', '40d9de00589211770a85c47d38c8ad61c598ec65d9332128a882eb8750e65a16'),
('modules/color/color.test', '013806279bd47ceb2f82ca854b57f880ba21058f7a2592c422afae881a7f5d15'),
('modules/comment/comment.module', 'db858137ff6ce06d87cb3b8f5275bed90c33a6d9aa7d46e7a74524cc2f052309'),
('modules/comment/comment.test', '23250d17c53fae6dd68202bc543901cc44e6ae233ffd4657c1b0c14ef4dee2d4'),
('modules/contextual/contextual.test', '023dafa199bd325ecc55a17b2a3db46ac0a31e23059f701f789f3bc42427ba0b'),
('modules/dashboard/dashboard.test', '125df00fc6deb985dc554aa7807a48e60a68dbbddbad9ec2c4718da724f0e683'),
('modules/dblog/dblog.test', '79ba7991c3f40f9241e9a03ffa43faf945c82658ca9b52ec62bd13bd80f41269'),
('modules/field/field.attach.inc', '2df4687b5ec078c4893dc1fea514f67524fd5293de717b9e05caf977e5ae2327'),
('modules/field/field.info.class.inc', 'cf18178e119d43897d3abd882ba3acc0cf59d1ad747663437c57b1ec4d0a4322'),
('modules/field/field.module', '48b5b83f214a8d19e446f46c5d7a1cd35faa656ccb7b540f9f02462a440cacdd'),
('modules/field/modules/field_sql_storage/field_sql_storage.test', '315eedaf2022afc884c35efd3b7c400eddab6ea30bec91924bc82ab5cd3e79f2'),
('modules/field/modules/list/tests/list.test', 'c1a214d7efd3247dd947d742a8514ec9649da62593608dfdccee6913d48e5709'),
('modules/field/modules/number/number.test', 'c890be184bc407631665cbc6e6f5b109953489feb15ea9bd7756f6fc2a1d15a4'),
('modules/field/modules/options/options.test', '20513f63a29cbba50b263de9206317c4aaf4b48828a0d2b0520fabaee0a237e6'),
('modules/field/modules/text/text.test', '5c28b9da26417d2ed8a169850989c0b59f2b188a0161eb58e2b87c67994d602d'),
('modules/field/tests/field.test', '5eaad7a933ef8ea05b958056492ce17858cd542111f0fe81dd1a5949ad8f966e'),
('modules/field_ui/field_ui.test', 'f535e5627c969e9083a63aaf72d4ac645e30709d7b87af15c6c3b870481f283a'),
('modules/file/tests/file.test', '23f47eeb3d5831af98accfa82659ee7de7f63286e14b807607d4193120cab6ac'),
('modules/filter/filter.test', 'b8aa5e6b832422c6ad5fe963898ec9526c814614f27ecccb67107ce194997d6a'),
('modules/help/help.test', 'bc934de8c71bd9874a05ccb5e8f927f4c227b3b2397d739e8504c8fd6ae5a83c'),
('modules/image/image.test', '6e7a0cbcb58f6210127b0ac7c1d118d488abd0925fe8db10a3405af87f1d9fe1'),
('modules/menu/menu.test', '71efd7117a882fdcdd50971b4a68f7f2895b532e09acf094d747f27a15742c5b'),
('modules/node/node.module', '70f969229d03819dba439546ae7aef30283b93e410af1b45f5a25b90d3cb8edd'),
('modules/node/node.test', '35bf40fde62f3a1de95bab9f037b84f20c2f93a1c579d7d19e4a87afe75dc330'),
('modules/path/path.test', '2004183b2c7c86028bf78c519c6a7afc4397a8267874462b0c2b49b0f8c20322'),
('modules/rdf/rdf.test', '9849d2b717119aa6b5f1496929e7ac7c9c0a6e98486b66f3876bda0a8c165525'),
('modules/search/search.extender.inc', '013a6a841cc48a6dc991153fb692b8d1546e56b78d9c95e97e0d7e92296d3481'),
('modules/search/search.test', '84e3939f935d661ecc856549719dae35c6eb8825f4540454cf78774a87d5d85b'),
('modules/shortcut/shortcut.test', '0d78280d4d0a05aa772218e45911552e39611ca9c258b9dd436307914ac3f254'),
('modules/system/system.archiver.inc', 'faa849f3e646a910ab82fd6c8bbf0a4e6b8c60725d7ba81ec0556bd716616cd1'),
('modules/system/system.mail.inc', 'd31e1769f5defbe5f27dc68f641ab80fb8d3de92f6e895f4c654ec05fc7e5f0f'),
('modules/system/system.queue.inc', 'a77a5913d84368092805ac551ca63737c1d829455504fcccb95baa2932f28009'),
('modules/system/system.tar.inc', 'd0d2f191d79b3227852e7436908386bdd7a25f78c73f3c8bf9ef5903892ae993'),
('modules/system/system.test', '774814fe27916708be54e275df999d900782fece40cc8526f77556db2dd01102'),
('modules/system/system.updater.inc', '9433fa8d39500b8c59ab05f41c0aac83b2586a43be4aa949821380e36c4d3c48'),
('modules/taxonomy/taxonomy.module', '9ab4bfec327be23de5833fcedf12b935fd8739851a53acf931422c293994998b'),
('modules/taxonomy/taxonomy.test', '5561c9de8ac6cc4bc77b7587248a798ab9ee603bbc130fe62c998e1e2b47af5d'),
('modules/update/update.test', '994b66b737f16eb98ee18c9e9ecd62e86de2792159e70b36982e95b48f2746a3'),
('modules/user/user.module', 'a1d316fcd7d849a1b31aacd029b36ed2695481035251347abe865d5fcc87eea4'),
('modules/user/user.test', 'aa8aa5e3673e9f9a3a75d5465f433c9b43633f8fd05bc4f6055942162e65f42e'),
('sites/all/modules/admin_menu/tests/admin_menu.test', '185f8244f7a086cda1bd9435ec529e8632598e9b09d1e0d7363b75cf87c04afb'),
('sites/all/modules/civicrm/drupal/civicrm.install', 'faf7a6e45cac972b25cac4b0de750b682ec9db1ff2491be15856c31b3924a054'),
('sites/all/modules/civicrm/drupal/civicrm.module', 'df3f2924fc2364edc7a9a4a3b98ade3883ef14f78ad213a516310aef52faee57'),
('sites/all/modules/civicrm/drupal/civicrm_user.inc', '4dbd3bc770c149a7354e6d1703a10aba42f4d62f36b97a5c0f324c07843ceacb'),
('sites/all/modules/civicrm/drupal/modules/civicrmtheme/civicrmtheme.install', 'df96376d47bb3098c7a15d49d75a870f36ad00e922cd5e2e5004962555716511'),
('sites/all/modules/civicrm/drupal/modules/civicrmtheme/civicrmtheme.module', 'eb011d97879f6805c7670226f49d02743cce54a5ed3394b67a742444eac45af3'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm.views.inc', '5486e029f703112075938838f52117fd9ae563ab62c45adc402a9bee5440e4e8'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm.views_default.inc', 'a308720f10e0d367fed9c58879b09d50665f54f5ae3ef769774042120784e9a5'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field.inc', '88e7a634d36ee851078377ff2bde692bff9ae96d329f80321ba72beb861a9eef'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_activity.inc', 'ed0a31b157e150780ddc00b099e8a703a848401d0925eedd97e39da3dca28a5d'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_address.inc', '62727ae5780344beef9e718829540b3bdef64840e9faf1a42432de2cda4e5def'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_component.inc', 'c8a26dc9c51a92d770256f64892fff5c4a281e9ea27fba2ffce32b4a7bfeb67d'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_contact_image.inc', '46175a196c21a4964006cf438f92534c73f0e577f8c9327e858441b0c762fe03'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_contact_link.inc', '17b7128523a1c4be6131cf4d71a1314c05850bc09f56df237d5820d6e94cb5ef'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_country.inc', '5dad61855f0ada2ae2b9cc57d3dbc1013e6a18c795d36e93a0b6c64485275336'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_county.inc', 'f7743778aa0d3707ad6517b72219e36e39f83357553b6ca7b93515bac3f98fdd'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_custom.inc', '98ecc06f1ac98a320b24a14ce1812ede6b93db9db1f0617bd3a8327fbe34bf70'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_custom_file.inc', '9deba5ef9eaa55f5a92867a4f704e13671290db64574a1707ade75cd11bfb479'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_datetime.inc', '417158cdee93a147cc231164ea6f2b5860613b62bd28c0412f328861c25bc113'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_drupalid.inc', '709cf09ae3f55f05ca12ec6b00e3c8516f222e2f13d6dc56bf92b8d0a0dca416'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_email.inc', '3e069d1aece0fad371c33bc114b0ac83119382c4b89046f367048af00d4747c5'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_encounter_medium.inc', '976e4cb66548cd4d8dce1f263a228e6de933a2841c3703920e23e2001d55a829'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_event.inc', '52c9f56e70191354e9f67cd9424bcdcbaccdf2d00b3ec9804e837c7ea8265c8a'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_event_link.inc', '7c5e74a8db01fcb8150fa6215cecc99df6f16aee514ec3aa189d8d4a3b337995'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_file.inc', '9deba5ef9eaa55f5a92867a4f704e13671290db64574a1707ade75cd11bfb479'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link.inc', 'db65f12b734e09851bad79dc10770f3d86918a25ad1852f78398b9c00c8a66b7'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_activity.inc', 'f3b65f0ef5ef68980885a9168e0dace46a2a003c4de1a7012b81d5ac085bfceb'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_contact.inc', '4e2bcb9b4d630e6306d7927c73c228664cd44f4bf2ded36b4be24022cbb421f1'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_contribution.inc', 'bc9299986acf2ac9d0fd6065a1253b7b821df238641cf42c7b17a5a1bc11f2e0'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_delete.inc', '0f8b4dbe93cf7fd866e7bc637213d464797143e729fdee6aa0851987759cde01'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_edit.inc', '532bbb5172fae7ad72e29966f0aa9384958bda5c0a207d91ce1cb189fca76c7f'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_event.inc', '586a2a6a53d6708ac5a7b673582f29901b3d5f28b77851eb68355c1f77bd56e6'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_participant.inc', '0ee5efd8459712de27a938c0ac593fa08bcde515b2c890525a1bc6aefcbc2230'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_pcp.inc', '96ac5617751ccfb2281ce31c7490dfd9f2837357366c20a32be887080502580f'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_link_relationship.inc', 'c03e119d4fb8af5574e28625581dbd7fe83ac7e1e071a291943e8ecc76897e8e'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_location.inc', '660efa85c182e629758d0a566d9489203c5f2ea01be5ab66f2fd9a36c1bb1677'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_mail.inc', 'f1d792215e1d86a89522b5610d2f638113fbba3abfe4b67dbc36b159b945cc34'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_markup.inc', 'b764ec2ed8eb0bfe00badbc78a02befe95636cc5abff3a32969f30d6f4e8fa2e'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_money.inc', '233d9772024945a97adb853a95fb2adc28aebc47277f0686715244933c3fdd23'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_option.inc', '55029b771b040e65d1b3958c065f24d8cbc36335a3209fb3c57d199fbf16212a'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_pcp_raised_amount.inc', '2e5a4b067ea77752e0d18104b35fbebf4d61c57a720d54fc71f82dfb0179b25a'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_phone.inc', '93279d01b331f5de24d428a78e336d22282ff90d0b61b869a3b378b4b80d0516'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_pseudo_constant.inc', '6983030fb1a59e51d9e4084a60417d10ec32e4e5285932f3dd777259e23a8ff4'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_relationship_type.inc', '3a70900669f0a4830df2a082e4364cb6dc047d064cb81f81ad1036cdaa99a245'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_field_state.inc', 'a41403048e0d7a3407bd2b9cf1adeeec865e659e36f667c539893ae062cd6604'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_country_multi.inc', '735d3d53df12afabd9444fc5dc2f9a986b294b5240ffa22bc326a2730eeb98d9'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_custom_option.inc', '4f5ee891dfdeca7c4e48039f886baf44c76ab8fb8d74be8f3872dcc72a15344b'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_custom_single_option.inc', 'ecf84b02b277b1e1f5ad5a1612ac7a0770ef6c08d4b419c7454cb82f4f241a56'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_datetime.inc', '4f5e0f3b854770e890f3b53d72fe761748b3076c4dd5fa4e5b170eddac829e0a'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_domain.inc', '22bee58157bf2971088d324fe49863f42b01dd5cc5e05b821278c7d79ea2d32d'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_encounter_medium.inc', 'af0a530d60796522655705fe3967483d225b5c1e685c39fb49d1fd2ad01cb4c5'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_group_status.inc', '9f8b294b05a1091908a04f3c8bd4f8b0f233187431a1a2616a31b19b9b2f166a'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_pseudo_constant.inc', '2093cf5a97b8c6e6d04f91ce41b543410e7732f0ace9475bb201fc43c5e60928'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_relationship_type.inc', '7cc311f4d8ad734fadc98703bd5a5669c8233904f941f807c8c598ef913d53da'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_filter_state_multi.inc', '5b164a2834e694e8411d2879635574657172e12b9794b56f2c6582380519a80f'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_relationship.inc', '20dbf61061386ddd5663f995f9d821d4ab2ed69c34430915b5992da3694ce824'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_relationship_contact2users.inc', 'e12514c78e3ebaca6c92e62a83a3872402ce4332a442a4a723503a8e1f7d6106'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_relationship_relationship.inc', 'ab65180aafb8d66eb74d7bffd8663d385a5a7745408e3ae533dcdda8fc615ba9'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_sort_date.inc', '132f053fb3c886283982f8f6d6c07f3ce4696c97c75ae297a785dea537747a6e'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_handler_sort_pcp_raised_amount.inc', '45c03a56301a5170a2d175031404bbbfb106cad637bed550541c9dbd202f9429'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/civicrm_plugin_argument_default.inc', 'e83dd4c2142805252c0dd5485c201d736cf9ba0f0b4d7f163b0e7af6bf70e1a3'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_day.inc', 'f91a13661541a3ae1ec1c16548fa950209b718da6a5c9c5bb39e16c5c019718d'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_fulldate.inc', '8db20b9eada91ebd9fae858d22246833491a2e1111c5f3af85fb3b33f2b5af8d'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_month.inc', 'bcc5f6c35fc5a1b608a8d33c43ac0d6c2849b2ae9bdd268b8acc72ef25834d48'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_week.inc', 'a741d50cb51e10c2b4fbbc8a05c5efe1d8333055f688f6e6a2407438dae316f4'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_year.inc', '41de5156e113f0b6dde4dd43a52a4052c293824cc49868c6cac885105e380b45'),
('sites/all/modules/civicrm/drupal/modules/views/civicrm/views_handler_argument_civicrm_year_month.inc', 'f6baabf183f0158036c6093083ff390bd4865c6716628e40559714b96e8f6b32'),
('sites/all/modules/civicrm/drupal/modules/views/plugins/calendar_plugin_row_civicrm.inc', '20bc206929a8651442db6ee456e1ab20e0fa623dab01f89c8abd3cefe3430e3b'),
('sites/all/modules/civicrm/drupal/modules/views/plugins/calendar_plugin_row_civicrm_event.inc', 'c5d1782bbbadbce2b8d53d37ea03e9b2ea360a8b8bdc6a5e33180927901161b9'),
('sites/all/modules/civicrm/drupal/modules/views/plugins/civicrm_plugin_argument_default_civicrm_id.inc', 'aba35713831b877381266a382d2cab0dd082889f790b9b050a64cdc3a8cdc7e8'),
('sites/all/modules/ctools/includes/context.inc', '4082504a7e4ac0da7808dd86159fa2f161be3f3d310e9dbd94c199ae2e714143'),
('sites/all/modules/ctools/includes/css-cache.inc', 'db90ff67669d9fa445e91074ac67fb97cdb191a19e68d42744f0fd4158649cfa'),
('sites/all/modules/ctools/includes/math-expr.inc', '3c60674360d5caa754895f32d87cde6a122f61800d4b762e7e09d49501fd47b8'),
('sites/all/modules/ctools/includes/stylizer.inc', '3f91f5ed42fb6ee1b65ddef7ac22577b07a5d75ca1eb2df60041243ced5c7079'),
('sites/all/modules/ctools/plugins/export_ui/ctools_export_ui.class.php', '2fd87a7d80689e4d44673b31c07b762144eb8ac57324fd0b9cd9ede5f4ea34b5'),
('sites/all/modules/ctools/tests/css_cache.test', '0dbc038efedb1fa06d2617b7c72b3a45d6ee5b5b791dcb1134876f174a2a7733'),
('sites/all/modules/entity/entity.features.inc', '53f537caf6ad9355fb92b2c6db019959abdf399d80764151dd976b0891f37436'),
('sites/all/modules/entity/entity.i18n.inc', '41e0e62af7e2774f62b162d597bb3244551c280296b692b29d039a2c243d7059'),
('sites/all/modules/entity/entity.info.inc', '8799080b9393c9560e64feae1276fb7d26fef4d92bb0edacc863ee3e7b67bf04'),
('sites/all/modules/entity/entity.rules.inc', '774199059d1b3ebe6d3fe7a49dbb1550df489055a3d066b5de54edda8dd7ba84'),
('sites/all/modules/entity/entity.test', 'aba6490cd2041438d832dc8f63b213e0d171a5a218f6d51a9fe00c51e95069ce'),
('sites/all/modules/entity/entity_token.module', '0c1ad6fb6f8c430e47a81be6d08180883c5a1ee728ce8b5dd0775713b34fb862'),
('sites/all/modules/entity/entity_token.tokens.inc', '084edf8f860f3c9843e23cc2e06a9084dcb644ee6d99c21cdd7bd924138d518f'),
('sites/all/modules/entity/includes/entity.controller.inc', 'b85d1882fae38ee8a0e82bf75952f44f65a58fd95e3bf0c3cb2a1321cf4d308a'),
('sites/all/modules/entity/includes/entity.inc', '02c3c8b1d4b7230f875c4fae8e6ba3bd57431e01f312b32f3ed305a7be734774'),
('sites/all/modules/entity/includes/entity.ui.inc', '49653cbbccc4b4e51f957727aa95803c149fac9565f53ed553e2cd1c1c3580ff'),
('sites/all/modules/entity/includes/entity.wrapper.inc', 'ba890faf0f18d6262bc211db1fdf0ca7742058b1f454cf3d9a9f281c71bface7'),
('sites/all/modules/entity/views/entity.views.inc', '089b8ed3103f62778be3395a99ddfbd84da4235f5ad431392f8984eaa4bf349f'),
('sites/all/modules/entity/views/handlers/entity_views_field_handler_helper.inc', '88e4cbbbeab9bbaa4c928118bdefb158ea99f343f813cf88cce01ed7fbf8bf6a'),
('sites/all/modules/entity/views/handlers/entity_views_handler_area_entity.inc', '7b7bb88e53861739b7279f705f0492fc83ce95f5b20d89339480f546422ebf25'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_boolean.inc', 'b28b8eee8761ba7a6af35d97ab7aaee28406e6c227271f9769818560626c5791'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_date.inc', 'b0f5be5b399de94934b24e84c8cf6053a043f6b00c60dcffa752daeafdd38778'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_duration.inc', 'ed7bb64cb63b94a20c8cde98cfb053b5ea252804396cf61ac562faf1d850266b'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_entity.inc', '4f255918a22fefebe9c7734f200751457a7ca4d3648e32a98511bb51968d7521'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_field.inc', '893121efbce2a7181e31147bade260c9cc657cbd33b0d254cb28b2650e57566d'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_numeric.inc', 'f14e2b063930e8820af381b4f5e83c7278440e7804ab88cfde865b6c94e7c0f6'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_options.inc', '27ef31b8ee7b9999930380d6a5fdb477772329c4ddbd5c70cc34bcdc7543ce56'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_text.inc', '5fb0a85d35d29944c699ceaf6efed5eda2df757009e44caba8ff2be397568b60'),
('sites/all/modules/entity/views/handlers/entity_views_handler_field_uri.inc', '79ecaa3eb17dfdd0ca077351b75a2c0adf411ebc04720e7cc0e2397674225f24'),
('sites/all/modules/entity/views/handlers/entity_views_handler_relationship.inc', 'b69bc538d1e1e0f91f8485ca54c3b6e2be025caa47619734c467377cf89041b9'),
('sites/all/modules/entity/views/handlers/entity_views_handler_relationship_by_bundle.inc', '65300c793c4591d60ad908dc02cf3148fe4e899fa6ad218e875fd92d411374dc'),
('sites/all/modules/entity/views/plugins/entity_views_plugin_row_entity_view.inc', 'e489ca209c66b76228383864b8267067e7cf3a1e375d9a195339f89932fed71f'),
('sites/all/modules/entityreference/entityreference.migrate.inc', '6dfe7be97f3198bff6c145dce9a0f521c3695c380d24fe6d3feb97362363407d'),
('sites/all/modules/entityreference/plugins/behavior/abstract.inc', 'a7959ddece2ce3490f92d916162e07aed313e28ca299ca0375bad633b42d93e3'),
('sites/all/modules/entityreference/plugins/behavior/EntityReferenceBehavior_TaxonomyIndex.class.php', '92fa0cf46ecdf6200659646e6666c562ea506c40efa41a8edd4758dc0c551b92'),
('sites/all/modules/entityreference/plugins/selection/abstract.inc', '7ecf94f5dc3456e4a5c87117d19deb98c368617fb07d610505b1dfa351f14a0b'),
('sites/all/modules/entityreference/plugins/selection/EntityReference_SelectionHandler_Generic.class.php', '4e1483f4b1fd242d3c7c92b098d0254b9b4b3e68c9f93aa7c8815e9cea2b3912'),
('sites/all/modules/entityreference/plugins/selection/views.inc', '7bbe8900b6b71c2d41e370deaccca869884d0fe9ca81772d7d5bca5f58ec1cd8'),
('sites/all/modules/entityreference/tests/entityreference.admin.test', '9b38cb7f8a55bfcd5c4e009297849d09bfd0a6465c7eac76b418f5cba927004b'),
('sites/all/modules/entityreference/tests/entityreference.feeds.test', 'b19193542031d2e1a247ffac8852e9219e5f7f0ed38298207ffe27cd1af9352a'),
('sites/all/modules/entityreference/tests/entityreference.handlers.test', '2fa170925ac5303c519378f1763e918cc2f111205220d90998b547a08db90d8c'),
('sites/all/modules/entityreference/tests/entityreference.taxonomy.test', '8e4f7d9ae621df0f587b6fcbf139adea2a35c69305ef018ced88447a41164c5f'),
('sites/all/modules/entityreference/views/entityreference_plugin_display.inc', '9216a065ea4fdb2daacb1280e5c9549e3400b8553b5293534cf65a0d703ab189'),
('sites/all/modules/entityreference/views/entityreference_plugin_row_fields.inc', '7f5a58c099c2df6fd1c3ae285197a4648841d44fa107bcb2064bc1edf435ea8b'),
('sites/all/modules/entityreference/views/entityreference_plugin_style.inc', 'ad9a7ea5a37c2d9658c2b1d19ade3011c27ed5d9959423ebf7a390372507e6b0'),
('sites/all/modules/module_filter/css/module_filter.css', '2813d8a7a9cca73ac2e7a5e3979d6e913f78cc36dbfe5e21c412eeb9a8fe97fc'),
('sites/all/modules/module_filter/css/module_filter_tab.css', '4e505f0aa9e9ba6306f0c1fe900ec5efcdd6de983748e4eee9491ebb03d85c63'),
('sites/all/modules/module_filter/js/module_filter.js', '4bb9003d81e4ad063abb22e6820fd35072bb1bcb6a340c7d8034bbc6c5e81b95'),
('sites/all/modules/module_filter/js/module_filter_tab.js', 'bb0ce3b3bddc0255175b2e3d0700206b1c10b645c7382d22ff7b897fedc9e750'),
('sites/all/modules/module_filter/module_filter.admin.inc', '15784b28ac9e77ba6e299b1a60b5d3176dc6fa3ecaba50dc60a1e0c56f925192'),
('sites/all/modules/module_filter/module_filter.install', '46a1159d2f88bb2db41a8c4c1378c6385d02d0aa689cc2940ecd4924d508c9f5'),
('sites/all/modules/module_filter/module_filter.module', '31d1273dbf8896a75abaf22a851b20f3653defacac9432ef5d430dc520998560'),
('sites/all/modules/module_filter/module_filter.theme.inc', '2f052942faf0585ee84dc90cf88152450a7a0cc09b958dd59526970d363ffe3a'),
('sites/all/modules/og/includes/migrate/7000/og_add_fields.inc', '6a73ed466f25dcadf916bb3d4c50acadc878df953a8c6b14de2a5cdc7433c75f'),
('sites/all/modules/og/includes/migrate/7000/og_content.inc', 'a47674a0520c67ffe5616aa884195d6c6c1dd7dc1cbbb6ba775970f3fb58182d'),
('sites/all/modules/og/includes/migrate/7000/og_group.inc', 'fd63f2cadeccdec18dde95400c0e0b219d1d43935eb20a88cab05613b6b6a742'),
('sites/all/modules/og/includes/migrate/7000/og_ogur.migrate.inc', '1907488491bed627c48fa26b65564ea9e1b6b80a3c0994cf7515250c3ba17799'),
('sites/all/modules/og/includes/migrate/7000/og_ogur_roles.migrate.inc', 'f5896c78953fcc4aa60f9149d54631415eb9362dbf2989bf806254f4ad832429'),
('sites/all/modules/og/includes/migrate/7000/og_user.inc', '8948a0fdfefbf313bbaffd9ce2fdc37a58c2de50bf366cf3d681e744778790ec'),
('sites/all/modules/og/includes/migrate/7200/og_og_membership.migrate.inc', '117433f56ddab23fc6a123f3a49cad3f9273dc77e762cc45f68f9e7675103914'),
('sites/all/modules/og/includes/migrate/7200/og_roles.migrate.inc', '47b374706ce4938323514b248e7fdf1a056169246561ed15876c972ee86732dc'),
('sites/all/modules/og/includes/migrate/7200/og_user_roles.migrate.inc', 'aa34a175f63a2a075dffd3921a89c9f72555818294f21cb098aa6f0b5f5f1ee0'),
('sites/all/modules/og/includes/migrate/og.migrate.inc', '0d542a6eded3405b3bfd4c21fd2e64858340d95873664125596badad79553688'),
('sites/all/modules/og/includes/migrate/plugins/destinations/og_membership.inc', '5d0424ebe1bc1b353e87f74db7888f2836471fc0f15d92177d86f931e103fb23'),
('sites/all/modules/og/includes/og.admin.inc', 'ad537f624756a4273c5c0a231a0578fb0c75c12af74c781522cb4d7a1e2b5ae3'),
('sites/all/modules/og/includes/og.exception.inc', 'e8eae64476076dd5b5cd6304d2540fa6d270671808e72862f335d0fec74366fc'),
('sites/all/modules/og/includes/og.membership.inc', 'ab480f91038ad8041715288c7f94a02fbc29a519e35a622713e1a8f6d1d4acf2'),
('sites/all/modules/og/includes/og.membership_type.inc', '7b137bf178ba2bca2c8da889af9adcf84eaa63ff9bc551f9ad7a7f709da7aa98'),
('sites/all/modules/og/includes/views/handlers/og_handler_field_group_audience_state.inc', 'ea1a719eb788592678ab86f7a2223279448156423b4bb6fe083ebb6914a3ebd2'),
('sites/all/modules/og/includes/views/handlers/og_handler_field_group_permissions.inc', '2bfcf87410485b83f5356203f65e4f6a87b9e27cf4b05bf814554cd3b779a8f1'),
('sites/all/modules/og/includes/views/handlers/og_handler_field_og_membership_link_delete.inc', 'fe4ee2bcab55c8a39d095e6505433476f418672b8719b4d9e1e70e58810e2437'),
('sites/all/modules/og/includes/views/handlers/og_handler_field_og_membership_link_edit.inc', '7290310d423042db3b70ee66305c98e60a277c1a84a3e1861443ab79630784ad'),
('sites/all/modules/og/includes/views/handlers/og_handler_field_prerender_list.inc', '313298f884c77f1a4a4806b63808d258365aba077ee9af7472603e28d04aeb21'),
('sites/all/modules/og/includes/views/handlers/og_handler_field_user_roles.inc', '457dd1d01d560910cf7f307c6faf8e7bab95c62da293f8f8a662a155ea64604b'),
('sites/all/modules/og/includes/views/handlers/og_handler_filter_group_audience_state.inc', 'ad4895c02f9967b1e1bc1610c3488ca257cebe0a615a9de1dfea88e4daf0e285'),
('sites/all/modules/og/includes/views/handlers/og_handler_filter_user_roles.inc', 'b683b1e48e90c2508c82ff2e848024996b923a6af19b51619fb417876241548f'),
('sites/all/modules/og/includes/views/handlers/og_handler_relationship.inc', '2ad707c0f7ffe510a6e0549189437667e4ec4b11c33c9f1cca136f118e5bb49c'),
('sites/all/modules/og/includes/views/handlers/og_handler_relationship_membership_roles.inc', '8364d56a5f3964dc9d75ad9d4797e2255d511fe8fc8015da5b9f8406bd7b0e05'),
('sites/all/modules/og/includes/views/handlers/og_plugin_argument_default_user_groups.inc', '2b566b3307156f107a228117bfb5022cb6db03f3c989e69c3fd5ddfbe8f794ce'),
('sites/all/modules/og/includes/views/handlers/og_plugin_argument_validate_group.inc', 'abfc3cba7f1e260f8e6a3830a451c702ee92526e5837de0fb29f3eacfe013fe1'),
('sites/all/modules/og/includes/views/og.views.inc', 'af041557f1cae4b419497718d06bdbb40f81b269ef99fb0a378150153847cc8d'),
('sites/all/modules/og/og.info.inc', '660185ea046f5321c136ef60b79aaa7341cd4a529d5d83c3567e3747bd80e42e'),
('sites/all/modules/og/og.test', '90b281f726004403489f1ca609d95182cec175f0f4777aeaa9bc2b58183a9fbd'),
('sites/all/modules/og/plugins/entityreference/behavior/OgBehaviorHandler.class.php', 'c6caa0d435c9bd4279f85c5f61c72d0a601f1c2a8aed5a409c7554f2bf153e64'),
('sites/all/modules/og/plugins/entityreference/behavior/OgWidgetHandler.class.php', 'c49e8043a4b0c00174dc14d6b48220e49fef9d34ffa3e74da5b19a6e56ba9841'),
('sites/all/modules/og/plugins/entityreference/selection/OgSelectionHandler.class.php', 'd0b568336af06bdaa49303662de8cd1290b21525a4e06758e9dfbf12ea0f5685'),
('sites/all/modules/rules/includes/faces.inc', '72352c57a12e740b80e235ee5fe245b91c5bca9938f4751670acc8e719626bcb'),
('sites/all/modules/rules/includes/rules.core.inc', 'e7d13cae20c6610a6236b1cedd891efdaf97490e1924e3c26c73994ca421d199'),
('sites/all/modules/rules/includes/rules.event.inc', '286bb8005acf30a6f4fdb23ff75843f70a82a99ac3e225c31290aad10e2a50ae'),
('sites/all/modules/rules/includes/rules.plugins.inc', 'd760fa99514c4acdc6e7abf6d820a979615304ed677eb291955356115dcbe44c'),
('sites/all/modules/rules/includes/rules.processor.inc', '902d554987e019cfe9c8818a83a96db7e02c556efb4c63961ee9d091ee98c988'),
('sites/all/modules/rules/includes/rules.state.inc', '26cb9d0792e6313e0582816527eef3e1310a07c5e3065b2b26e3408dca500bf0'),
('sites/all/modules/rules/modules/node.eval.inc', '7873fe5eaa00b0f6b189bb6e4d43efe63d587009e05ae502c15076c63b931a6c'),
('sites/all/modules/rules/modules/php.eval.inc', '4d579f9d83912a1ff4e3e35b20a7792fb7e282d8d07c706e944ffbb6b20c42f6'),
('sites/all/modules/rules/modules/rules_core.eval.inc', 'edf268c4e9a24d700ef08ca5cf8addc93a437d30cb0129aeb7aa93e76f8f855e'),
('sites/all/modules/rules/modules/system.eval.inc', '1076decc24a4779c7a582b446b9147d65ddd03cec530ee62809c86e49c62f736'),
('sites/all/modules/rules/rules.features.inc', 'dc219fc6df253743cfe775503edffd6ba8b76fe9d8b549294242b0691cad0302'),
('sites/all/modules/rules/tests/rules.test', '61d6f9cfb2ff09eb595639a31dbd651de0606288d7b85d29089f564bc91ca516'),
('sites/all/modules/rules/ui/ui.controller.inc', 'c0d16bd7340a766225865d942dcdad23aead4275e3f18b326e23f42f2313f30b'),
('sites/all/modules/rules/ui/ui.core.inc', 'ba58ed06bf4c3471c5958c2072315e016ab563a74291b89666b868214b8b0725'),
('sites/all/modules/rules/ui/ui.data.inc', '4646714b3c18f527193308316313944a410f95c3cc849c8605d6dcf63ef035c1'),
('sites/all/modules/rules/ui/ui.plugins.inc', 'd290f1ab6933f0a9189c5197c471d422d04d315b137079863ef746ed4ef673c4');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`rid`, `name`, `weight`) VALUES
(3, 'administrator', 2),
(1, 'anonymous user', 0),
(2, 'authenticated user', 1);

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE `role_permission` (
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';

--
-- Dumping data for table `role_permission`
--

INSERT INTO `role_permission` (`rid`, `permission`, `module`) VALUES
(1, 'access all custom data', 'civicrm'),
(1, 'access CiviMail subscribe/unsubscribe pages', 'civicrm'),
(1, 'access comments', 'comment'),
(1, 'access content', 'node'),
(1, 'access uploaded files', 'civicrm'),
(1, 'make online contributions', 'civicrm'),
(1, 'profile create', 'civicrm'),
(1, 'profile edit', 'civicrm'),
(1, 'profile view', 'civicrm'),
(1, 'register for events', 'civicrm'),
(1, 'use text format filtered_html', 'filter'),
(1, 'view event info', 'civicrm'),
(1, 'view event participants', 'civicrm'),
(2, 'access all custom data', 'civicrm'),
(2, 'access CiviMail subscribe/unsubscribe pages', 'civicrm'),
(2, 'access comments', 'comment'),
(2, 'access content', 'node'),
(2, 'access uploaded files', 'civicrm'),
(2, 'make online contributions', 'civicrm'),
(2, 'post comments', 'comment'),
(2, 'profile create', 'civicrm'),
(2, 'profile edit', 'civicrm'),
(2, 'profile view', 'civicrm'),
(2, 'register for events', 'civicrm'),
(2, 'skip comment approval', 'comment'),
(2, 'use text format filtered_html', 'filter'),
(2, 'view event info', 'civicrm'),
(2, 'view event participants', 'civicrm'),
(3, 'access administration menu', 'admin_menu'),
(3, 'access administration pages', 'system'),
(3, 'access AJAX API', 'civicrm'),
(3, 'access all custom data', 'civicrm'),
(3, 'access CiviContribute', 'civicrm'),
(3, 'access CiviCRM', 'civicrm'),
(3, 'access CiviEvent', 'civicrm'),
(3, 'access CiviMail', 'civicrm'),
(3, 'access CiviMail subscribe/unsubscribe pages', 'civicrm'),
(3, 'access CiviMember', 'civicrm'),
(3, 'access CiviPledge', 'civicrm'),
(3, 'access CiviReport', 'civicrm'),
(3, 'access comments', 'comment'),
(3, 'access Contact Dashboard', 'civicrm'),
(3, 'access contact reference fields', 'civicrm'),
(3, 'access content', 'node'),
(3, 'access content overview', 'node'),
(3, 'access contextual links', 'contextual'),
(3, 'access dashboard', 'dashboard'),
(3, 'access deleted contacts', 'civicrm'),
(3, 'access overlay', 'overlay'),
(3, 'access Report Criteria', 'civicrm'),
(3, 'access rules debug', 'rules'),
(3, 'access site in maintenance mode', 'system'),
(3, 'access site reports', 'system'),
(3, 'access toolbar', 'toolbar'),
(3, 'access uploaded files', 'civicrm'),
(3, 'access user profiles', 'user'),
(3, 'add contacts', 'civicrm'),
(3, 'administer actions', 'system'),
(3, 'administer blocks', 'block'),
(3, 'administer CiviCRM', 'civicrm'),
(3, 'administer comments', 'comment'),
(3, 'administer content types', 'node'),
(3, 'administer dedupe rules', 'civicrm'),
(3, 'administer fields', 'field'),
(3, 'administer filters', 'filter'),
(3, 'administer group', 'og'),
(3, 'administer image styles', 'image'),
(3, 'administer menu', 'menu'),
(3, 'administer module filter', 'module_filter'),
(3, 'administer modules', 'system'),
(3, 'administer nodes', 'node'),
(3, 'administer payment processors', 'civicrm'),
(3, 'administer permissions', 'user'),
(3, 'administer Reports', 'civicrm'),
(3, 'administer reserved groups', 'civicrm'),
(3, 'administer reserved reports', 'civicrm'),
(3, 'administer reserved tags', 'civicrm'),
(3, 'administer rules', 'rules'),
(3, 'administer search', 'search'),
(3, 'administer shortcuts', 'shortcut'),
(3, 'administer site configuration', 'system'),
(3, 'administer software updates', 'system'),
(3, 'administer Tagsets', 'civicrm'),
(3, 'administer taxonomy', 'taxonomy'),
(3, 'administer themes', 'system'),
(3, 'administer url aliases', 'path'),
(3, 'administer users', 'user'),
(3, 'block IP addresses', 'system'),
(3, 'bypass node access', 'node'),
(3, 'bypass rules access', 'rules'),
(3, 'cancel account', 'user'),
(3, 'change own username', 'user'),
(3, 'create article content', 'node'),
(3, 'create manual batch', 'civicrm'),
(3, 'create page content', 'node'),
(3, 'create url aliases', 'path'),
(3, 'customize shortcut links', 'shortcut'),
(3, 'delete activities', 'civicrm'),
(3, 'delete all manual batches', 'civicrm'),
(3, 'delete any article content', 'node'),
(3, 'delete any page content', 'node'),
(3, 'delete contacts', 'civicrm'),
(3, 'delete in CiviContribute', 'civicrm'),
(3, 'delete in CiviEvent', 'civicrm'),
(3, 'delete in CiviMail', 'civicrm'),
(3, 'delete in CiviMember', 'civicrm'),
(3, 'delete in CiviPledge', 'civicrm'),
(3, 'delete own article content', 'node'),
(3, 'delete own manual batches', 'civicrm'),
(3, 'delete own page content', 'node'),
(3, 'delete revisions', 'node'),
(3, 'delete terms in 1', 'taxonomy'),
(3, 'display drupal links', 'admin_menu'),
(3, 'edit all contacts', 'civicrm'),
(3, 'edit all events', 'civicrm'),
(3, 'edit all manual batches', 'civicrm'),
(3, 'edit any article content', 'node'),
(3, 'edit any page content', 'node'),
(3, 'edit api keys', 'civicrm'),
(3, 'edit contributions', 'civicrm'),
(3, 'edit event participants', 'civicrm'),
(3, 'edit groups', 'civicrm'),
(3, 'edit memberships', 'civicrm'),
(3, 'edit message templates', 'civicrm'),
(3, 'edit my contact', 'civicrm'),
(3, 'edit own api keys', 'civicrm'),
(3, 'edit own article content', 'node'),
(3, 'edit own comments', 'comment'),
(3, 'edit own manual batches', 'civicrm'),
(3, 'edit own page content', 'node'),
(3, 'edit pledges', 'civicrm'),
(3, 'edit terms in 1', 'taxonomy'),
(3, 'export all manual batches', 'civicrm'),
(3, 'export own manual batches', 'civicrm'),
(3, 'flush caches', 'admin_menu'),
(3, 'import contacts', 'civicrm'),
(3, 'import SQL datasource', 'civicrm'),
(3, 'make online contributions', 'civicrm'),
(3, 'manage event profiles', 'civicrm'),
(3, 'merge duplicate contacts', 'civicrm'),
(3, 'post comments', 'comment'),
(3, 'profile create', 'civicrm'),
(3, 'profile edit', 'civicrm'),
(3, 'profile listings', 'civicrm'),
(3, 'profile listings and forms', 'civicrm'),
(3, 'profile view', 'civicrm'),
(3, 'register for events', 'civicrm'),
(3, 'revert revisions', 'node'),
(3, 'search content', 'search'),
(3, 'select account cancellation method', 'user'),
(3, 'skip comment approval', 'comment'),
(3, 'skip IDS check', 'civicrm'),
(3, 'switch shortcut sets', 'shortcut'),
(3, 'translate CiviCRM', 'civicrm'),
(3, 'use advanced search', 'search'),
(3, 'use ctools import', 'ctools'),
(3, 'use text format filtered_html', 'filter'),
(3, 'use text format full_html', 'filter'),
(3, 'view all activities', 'civicrm'),
(3, 'view all contacts', 'civicrm'),
(3, 'view all manual batches', 'civicrm'),
(3, 'view all notes', 'civicrm'),
(3, 'view debug output', 'civicrm'),
(3, 'view event info', 'civicrm'),
(3, 'view event participants', 'civicrm'),
(3, 'view my contact', 'civicrm'),
(3, 'view my invoices', 'civicrm'),
(3, 'view own manual batches', 'civicrm'),
(3, 'view own unpublished content', 'node'),
(3, 'view public CiviMail content', 'civicrm'),
(3, 'view revisions', 'node'),
(3, 'view the administration theme', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `rules_config`
--

CREATE TABLE `rules_config` (
  `id` int(11) NOT NULL COMMENT 'The internal identifier for any configuration.',
  `name` varchar(64) NOT NULL COMMENT 'The name of the configuration.',
  `label` varchar(255) NOT NULL DEFAULT 'unlabeled' COMMENT 'The label of the configuration.',
  `plugin` varchar(127) NOT NULL COMMENT 'The name of the plugin of this configuration.',
  `active` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the configuration is active. Usage depends on how the using module makes use of it.',
  `weight` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Weight of the configuration. Usage depends on how the using module makes use of it.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `dirty` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Dirty configurations fail the integrity check, e.g. due to missing dependencies.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  `owner` varchar(255) NOT NULL DEFAULT 'rules' COMMENT 'The name of the module via which the rule has been configured.',
  `access_exposed` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether to use a permission to control access for using components.',
  `data` longblob COMMENT 'Everything else, serialized.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rules_config`
--

INSERT INTO `rules_config` (`id`, `name`, `label`, `plugin`, `active`, `weight`, `status`, `dirty`, `module`, `owner`, `access_exposed`, `data`) VALUES
(1, 'rules_og_member_active', 'OG member subscribe (Active)', 'reaction rule', 0, 0, 2, 0, 'og', 'rules', 0, 0x4f3a31373a2252756c65735265616374696f6e52756c65223a31383a7b733a393a22002a00706172656e74223b4e3b733a323a226964223b733a313a2231223b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a343a226e616d65223b733a32323a2272756c65735f6f675f6d656d6265725f616374697665223b733a353a226c6162656c223b733a32383a224f47206d656d62657220737562736372696265202841637469766529223b733a363a22706c7567696e223b733a31333a227265616374696f6e2072756c65223b733a363a22616374697665223b623a303b733a363a22737461747573223b693a323b733a363a226d6f64756c65223b733a323a226f67223b733a353a226f776e6572223b733a353a2272756c6573223b733a343a2264617461223b723a313b733a31313a22002a006368696c6472656e223b613a333a7b693a303b4f3a31313a2252756c6573416374696f6e223a363a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a353a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a343a2274797065223b733a343a226e6f6465223b733a31323a2276616c75653a73656c656374223b733a31393a226f672d6d656d626572736869703a67726f7570223b733a31383a227661726961626c655f61646465643a766172223b733a353a2267726f7570223b733a32303a227661726961626c655f61646465643a6c6162656c223b733a31343a224164646564207661726961626c65223b7d733a31343a22002a00656c656d656e744e616d65223b733a31323a227661726961626c655f616464223b7d693a313b4f3a31313a2252756c6573416374696f6e223a363a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a343a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a393a22746f3a73656c656374223b733a31323a226163636f756e743a6d61696c223b733a373a227375626a656374223b733a35383a22596f7572206d656d6265727368697020726571756573742077617320617070726f76656420666f7220275b67726f75703a7469746c655d270d0a223b733a373a226d657373616765223b733a39313a225b6163636f756e743a6e616d655d2c0d0a0d0a596f7520617265206e6f772061206d656d62657220696e207468652067726f757020275b67726f75703a7469746c655d27206c6f6361746564206174205b67726f75703a75726c5d223b7d733a31343a22002a00656c656d656e744e616d65223b733a343a226d61696c223b7d693a323b4f3a31313a2252756c6573416374696f6e223a363a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a343a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a393a22746f3a73656c656374223b733a31373a2267726f75703a617574686f723a6d61696c223b733a373a227375626a656374223b733a33353a225b6163636f756e743a6e616d655d206a6f696e6564205b67726f75703a7469746c655d223b733a373a226d657373616765223b733a37343a225b67726f75703a617574686f723a6e616d655d2c0d0a0d0a5b6163636f756e743a6e616d655d206a6f696e6564205b67726f75703a7469746c655d20696e205b67726f75703a75726c5d223b7d733a31343a22002a00656c656d656e744e616d65223b733a343a226d61696c223b7d7d733a373a22002a00696e666f223b613a303a7b7d733a31333a22002a00636f6e646974696f6e73223b4f3a383a2252756c6573416e64223a383a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a31313a22002a006368696c6472656e223b613a323a7b693a303b4f3a31343a2252756c6573436f6e646974696f6e223a373a7b733a393a22002a00706172656e74223b723a35313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a343a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a31313a22646174613a73656c656374223b733a31393a226f672d6d656d626572736869703a7374617465223b733a323a226f70223b733a323a223d3d223b733a353a2276616c7565223b733a313a2231223b7d733a31343a22002a00656c656d656e744e616d65223b733a373a22646174615f6973223b733a393a22002a006e6567617465223b623a303b7d693a313b4f3a31343a2252756c6573436f6e646974696f6e223a373a7b733a393a22002a00706172656e74223b723a35313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a333a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a31333a22656e746974793a73656c656374223b733a31393a226f672d6d656d626572736869703a67726f7570223b733a343a2274797065223b733a343a226e6f6465223b7d733a31343a22002a00656c656d656e744e616d65223b733a31373a22656e746974795f69735f6f665f74797065223b733a393a22002a006e6567617465223b623a303b7d7d733a373a22002a00696e666f223b613a303a7b7d733a393a22002a006e6567617465223b623a303b7d733a393a22002a006576656e7473223b613a313a7b693a303b733a31343a226f675f757365725f696e73657274223b7d733a31363a22002a006576656e7453657474696e6773223b613a303a7b7d7d),
(2, 'rules_og_member_pending', 'OG member subscribe (Pending)', 'reaction rule', 0, 0, 2, 0, 'og', 'rules', 0, 0x4f3a31373a2252756c65735265616374696f6e52756c65223a31383a7b733a393a22002a00706172656e74223b4e3b733a323a226964223b733a313a2232223b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a343a226e616d65223b733a32333a2272756c65735f6f675f6d656d6265725f70656e64696e67223b733a353a226c6162656c223b733a32393a224f47206d656d62657220737562736372696265202850656e64696e6729223b733a363a22706c7567696e223b733a31333a227265616374696f6e2072756c65223b733a363a22616374697665223b623a303b733a363a22737461747573223b693a323b733a363a226d6f64756c65223b733a323a226f67223b733a353a226f776e6572223b733a353a2272756c6573223b733a343a2264617461223b723a313b733a31313a22002a006368696c6472656e223b613a333a7b693a303b4f3a31313a2252756c6573416374696f6e223a363a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a353a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a343a2274797065223b733a343a226e6f6465223b733a31323a2276616c75653a73656c656374223b733a31393a226f672d6d656d626572736869703a67726f7570223b733a31383a227661726961626c655f61646465643a766172223b733a353a2267726f7570223b733a32303a227661726961626c655f61646465643a6c6162656c223b733a31343a224164646564207661726961626c65223b7d733a31343a22002a00656c656d656e744e616d65223b733a31323a227661726961626c655f616464223b7d693a313b4f3a31313a2252756c6573416374696f6e223a363a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a343a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a393a22746f3a73656c656374223b733a31323a226163636f756e743a6d61696c223b733a373a227375626a656374223b733a34333a22596f7572206d656d62657273686970207265717565737420666f7220275b67726f75703a7469746c655d27223b733a373a226d657373616765223b733a3130333a225b6163636f756e743a6e616d655d2c0d0a0d0a596f7572206d656d6265727368697020746f2067726f757020275b67726f75703a7469746c655d27206c6f6361746564206174205b67726f75703a75726c5d2069732070656e64696e6720617070726f76616c2e223b7d733a31343a22002a00656c656d656e744e616d65223b733a343a226d61696c223b7d693a323b4f3a31313a2252756c6573416374696f6e223a363a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a343a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a393a22746f3a73656c656374223b733a31373a2267726f75703a617574686f723a6d61696c223b733a373a227375626a656374223b733a34373a225b6163636f756e743a6e616d655d206d656d626572736869702072657175657374205b67726f75703a7469746c655d223b733a373a226d657373616765223b733a3134313a225b67726f75703a617574686f723a6e616d655d2c0d0a0d0a5b6163636f756e743a6e616d655d207265717565737473206d656d6265727368697020666f722067726f757020275b67726f75703a7469746c655d2720696e205b67726f75703a75726c5d2e0d0a0d0a5b6f675f6d656d626572736869703a6f672d6d656d626572736869702d726571756573745d223b7d733a31343a22002a00656c656d656e744e616d65223b733a343a226d61696c223b7d7d733a373a22002a00696e666f223b613a303a7b7d733a31333a22002a00636f6e646974696f6e73223b4f3a383a2252756c6573416e64223a383a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a31313a22002a006368696c6472656e223b613a323a7b693a303b4f3a31343a2252756c6573436f6e646974696f6e223a373a7b733a393a22002a00706172656e74223b723a35313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a343a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a31313a22646174613a73656c656374223b733a31393a226f672d6d656d626572736869703a7374617465223b733a323a226f70223b733a323a223d3d223b733a353a2276616c7565223b733a313a2232223b7d733a31343a22002a00656c656d656e744e616d65223b733a373a22646174615f6973223b733a393a22002a006e6567617465223b623a303b7d693a313b4f3a31343a2252756c6573436f6e646974696f6e223a373a7b733a393a22002a00706172656e74223b723a35313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a333a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a31333a22656e746974793a73656c656374223b733a31393a226f672d6d656d626572736869703a67726f7570223b733a343a2274797065223b733a343a226e6f6465223b7d733a31343a22002a00656c656d656e744e616d65223b733a31373a22656e746974795f69735f6f665f74797065223b733a393a22002a006e6567617465223b623a303b7d7d733a373a22002a00696e666f223b613a303a7b7d733a393a22002a006e6567617465223b623a303b7d733a393a22002a006576656e7473223b613a313a7b693a303b733a31343a226f675f757365725f696e73657274223b7d733a31363a22002a006576656e7453657474696e6773223b613a303a7b7d7d),
(3, 'rules_og_new_content', 'OG new content notification', 'reaction rule', 0, 0, 2, 0, 'og', 'rules', 0, 0x4f3a31373a2252756c65735265616374696f6e52756c65223a31383a7b733a393a22002a00706172656e74223b4e3b733a323a226964223b733a313a2233223b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a343a226e616d65223b733a32303a2272756c65735f6f675f6e65775f636f6e74656e74223b733a353a226c6162656c223b733a32373a224f47206e657720636f6e74656e74206e6f74696669636174696f6e223b733a363a22706c7567696e223b733a31333a227265616374696f6e2072756c65223b733a363a22616374697665223b623a303b733a363a22737461747573223b693a323b733a363a226d6f64756c65223b733a323a226f67223b733a353a226f776e6572223b733a353a2272756c6573223b733a343a2264617461223b723a313b733a31313a22002a006368696c6472656e223b613a323a7b693a303b4f3a31313a2252756c6573416374696f6e223a363a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a343a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a32303a2267726f75705f636f6e74656e743a73656c656374223b733a343a226e6f6465223b733a31373a2267726f75705f6d656d626572733a766172223b733a31333a2267726f75705f6d656d62657273223b733a31393a2267726f75705f6d656d626572733a6c6162656c223b733a32313a224c697374206f662067726f7570206d656d62657273223b7d733a31343a22002a00656c656d656e744e616d65223b733a31343a226f675f6765745f6d656d62657273223b7d693a313b4f3a393a2252756c65734c6f6f70223a373a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a333a7b733a383a226974656d3a766172223b733a393a226c6973745f6974656d223b733a31303a226974656d3a6c6162656c223b733a31373a2243757272656e74206c697374206974656d223b733a31313a226c6973743a73656c656374223b733a31333a2267726f75702d6d656d62657273223b7d733a31313a22002a006368696c6472656e223b613a313a7b693a303b4f3a31313a2252756c6573416374696f6e223a363a7b733a393a22002a00706172656e74223b723a32373b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a353a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a393a22746f3a73656c656374223b733a31343a226c6973742d6974656d3a6d61696c223b733a373a227375626a656374223b733a31373a224e657720706f737420696e2067726f7570223b733a373a226d657373616765223b733a3134303a2248656c6c6f205b6c6973742d6974656d3a6e616d655d2c0d0a0d0a54686572652069732061206e657720706f73742063616c6c6564205b6e6f64653a7469746c655d20746861742062656c6f6e677320746f206f6e65206f66207468652067726f75707320796f7520617265207375627363726962656420746f2e0d0a0d0a5b736974653a6e616d655d0d0a223b733a31313a2266726f6d3a73656c656374223b733a303a22223b7d733a31343a22002a00656c656d656e744e616d65223b733a343a226d61696c223b7d7d733a373a22002a00696e666f223b613a303a7b7d7d7d733a373a22002a00696e666f223b613a303a7b7d733a31333a22002a00636f6e646974696f6e73223b4f3a383a2252756c6573416e64223a383a7b733a393a22002a00706172656e74223b723a313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a31313a22002a006368696c6472656e223b613a313a7b693a303b4f3a31343a2252756c6573436f6e646974696f6e223a373a7b733a393a22002a00706172656e74223b723a35313b733a323a226964223b4e3b733a31323a22002a00656c656d656e744964223b4e3b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a323a7b733a31383a22235f6e656564735f70726f63657373696e67223b623a313b733a31333a22656e746974793a73656c656374223b733a343a226e6f6465223b7d733a31343a22002a00656c656d656e744e616d65223b733a32363a226f675f656e746974795f69735f67726f75705f636f6e74656e74223b733a393a22002a006e6567617465223b623a303b7d7d733a373a22002a00696e666f223b613a303a7b7d733a393a22002a006e6567617465223b623a303b7d733a393a22002a006576656e7473223b613a313a7b693a303b733a31313a226e6f64655f696e73657274223b7d733a31363a22002a006576656e7453657474696e6773223b613a303a7b7d7d);

-- --------------------------------------------------------

--
-- Table structure for table `rules_dependencies`
--

CREATE TABLE `rules_dependencies` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier of the configuration.',
  `module` varchar(255) NOT NULL COMMENT 'The name of the module that is required for the configuration.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rules_dependencies`
--

INSERT INTO `rules_dependencies` (`id`, `module`) VALUES
(1, 'og'),
(2, 'og'),
(3, 'og'),
(1, 'rules'),
(2, 'rules'),
(3, 'rules');

-- --------------------------------------------------------

--
-- Table structure for table `rules_tags`
--

CREATE TABLE `rules_tags` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier of the configuration.',
  `tag` varchar(255) NOT NULL COMMENT 'The tag string associated with this configuration'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rules_trigger`
--

CREATE TABLE `rules_trigger` (
  `id` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier of the configuration.',
  `event` varchar(127) NOT NULL DEFAULT '' COMMENT 'The name of the event on which the configuration should be triggered.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rules_trigger`
--

INSERT INTO `rules_trigger` (`id`, `event`) VALUES
(1, 'og_user_insert'),
(2, 'og_user_insert'),
(3, 'node_insert');

-- --------------------------------------------------------

--
-- Table structure for table `search_dataset`
--

CREATE TABLE `search_dataset` (
  `sid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';

-- --------------------------------------------------------

--
-- Table structure for table `search_index`
--

CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';

-- --------------------------------------------------------

--
-- Table structure for table `search_node_links`
--

CREATE TABLE `search_node_links` (
  `sid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';

-- --------------------------------------------------------

--
-- Table structure for table `search_total`
--

CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';

-- --------------------------------------------------------

--
-- Table structure for table `semaphore`
--

CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';

-- --------------------------------------------------------

--
-- Table structure for table `sequences`
--

CREATE TABLE `sequences` (
  `value` int(10) UNSIGNED NOT NULL COMMENT 'The value of the sequence.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';

--
-- Dumping data for table `sequences`
--

INSERT INTO `sequences` (`value`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `uid` int(10) UNSIGNED NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';

-- --------------------------------------------------------

--
-- Table structure for table `shortcut_set`
--

CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';

--
-- Dumping data for table `shortcut_set`
--

INSERT INTO `shortcut_set` (`set_name`, `title`) VALUES
('shortcut-set-1', 'Default');

-- --------------------------------------------------------

--
-- Table structure for table `shortcut_set_users`
--

CREATE TABLE `shortcut_set_users` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';

-- --------------------------------------------------------

--
-- Table structure for table `system`
--

CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';

--
-- Dumping data for table `system`
--

INSERT INTO `system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/aggregator/aggregator.module', 'aggregator', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a31303a2241676772656761746f72223b733a31313a226465736372697074696f6e223b733a35373a22416767726567617465732073796e6469636174656420636f6e74656e7420285253532c205244462c20616e642041746f6d206665656473292e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a2261676772656761746f722e74657374223b7d733a393a22636f6e666967757265223b733a34313a2261646d696e2f636f6e6669672f73657276696365732f61676772656761746f722f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31343a2261676772656761746f722e637373223b733a33333a226d6f64756c65732f61676772656761746f722f61676772656761746f722e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/aggregator/tests/aggregator_test.module', 'aggregator_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32333a2241676772656761746f72206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a34363a22537570706f7274206d6f64756c6520666f722061676772656761746f722072656c617465642074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/block/block.module', 'block', 'module', '', 1, 0, 7009, -5, 0x613a31333a7b733a343a226e616d65223b733a353a22426c6f636b223b733a31313a226465736372697074696f6e223b733a3134303a22436f6e74726f6c73207468652076697375616c206275696c64696e6720626c6f636b732061207061676520697320636f6e737472756374656420776974682e20426c6f636b732061726520626f786573206f6620636f6e74656e742072656e646572656420696e746f20616e20617265612c206f7220726567696f6e2c206f6620612077656220706167652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22626c6f636b2e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f626c6f636b223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/block/tests/block_test.module', 'block_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22426c6f636b2074657374223b733a31313a226465736372697074696f6e223b733a32313a2250726f7669646573207465737420626c6f636b732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/blog/blog.module', 'blog', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a343a22426c6f67223b733a31313a226465736372697074696f6e223b733a32353a22456e61626c6573206d756c74692d7573657220626c6f67732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22626c6f672e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/book/book.module', 'book', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a343a22426f6f6b223b733a31313a226465736372697074696f6e223b733a36363a22416c6c6f777320757365727320746f2063726561746520616e64206f7267616e697a652072656c6174656420636f6e74656e7420696e20616e206f75746c696e652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22626f6f6b2e74657374223b7d733a393a22636f6e666967757265223b733a32373a2261646d696e2f636f6e74656e742f626f6f6b2f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22626f6f6b2e637373223b733a32313a226d6f64756c65732f626f6f6b2f626f6f6b2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/color/color.module', 'color', 'module', '', 1, 0, 7001, 0, 0x613a31323a7b733a343a226e616d65223b733a353a22436f6c6f72223b733a31313a226465736372697074696f6e223b733a37303a22416c6c6f77732061646d696e6973747261746f727320746f206368616e67652074686520636f6c6f7220736368656d65206f6620636f6d70617469626c65207468656d65732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22636f6c6f722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/comment/comment.module', 'comment', 'module', '', 1, 0, 7009, 0, 0x613a31343a7b733a343a226e616d65223b733a373a22436f6d6d656e74223b733a31313a226465736372697074696f6e223b733a35373a22416c6c6f777320757365727320746f20636f6d6d656e74206f6e20616e642064697363757373207075626c697368656420636f6e74656e742e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a2274657874223b7d733a353a2266696c6573223b613a323a7b693a303b733a31343a22636f6d6d656e742e6d6f64756c65223b693a313b733a31323a22636f6d6d656e742e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f636f6e74656e742f636f6d6d656e74223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31313a22636f6d6d656e742e637373223b733a32373a226d6f64756c65732f636f6d6d656e742f636f6d6d656e742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/contact/contact.module', 'contact', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a22436f6e74616374223b733a31313a226465736372697074696f6e223b733a36313a22456e61626c65732074686520757365206f6620626f746820706572736f6e616c20616e6420736974652d7769646520636f6e7461637420666f726d732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22636f6e746163742e74657374223b7d733a393a22636f6e666967757265223b733a32333a2261646d696e2f7374727563747572652f636f6e74616374223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/contextual/contextual.module', 'contextual', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a31363a22436f6e7465787475616c206c696e6b73223b733a31313a226465736372697074696f6e223b733a37353a2250726f766964657320636f6e7465787475616c206c696e6b7320746f20706572666f726d20616374696f6e732072656c6174656420746f20656c656d656e7473206f6e206120706167652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a22636f6e7465787475616c2e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/dashboard/dashboard.module', 'dashboard', 'module', '', 1, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2244617368626f617264223b733a31313a226465736372697074696f6e223b733a3133363a2250726f766964657320612064617368626f617264207061676520696e207468652061646d696e69737472617469766520696e7465726661636520666f72206f7267616e697a696e672061646d696e697374726174697665207461736b7320616e6420747261636b696e6720696e666f726d6174696f6e2077697468696e20796f757220736974652e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a353a2266696c6573223b613a313a7b693a303b733a31343a2264617368626f6172642e74657374223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a22626c6f636b223b7d733a393a22636f6e666967757265223b733a32353a2261646d696e2f64617368626f6172642f637573746f6d697a65223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/dblog/dblog.module', 'dblog', 'module', '', 1, 1, 7003, 0, 0x613a31323a7b733a343a226e616d65223b733a31363a224461746162617365206c6f6767696e67223b733a31313a226465736372697074696f6e223b733a34373a224c6f677320616e64207265636f7264732073797374656d206576656e747320746f207468652064617461626173652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a2264626c6f672e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/field.module', 'field', 'module', '', 1, 0, 7004, 0, 0x613a31343a7b733a343a226e616d65223b733a353a224669656c64223b733a31313a226465736372697074696f6e223b733a35373a224669656c642041504920746f20616464206669656c647320746f20656e746974696573206c696b65206e6f64657320616e642075736572732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a343a7b693a303b733a31323a226669656c642e6d6f64756c65223b693a313b733a31363a226669656c642e6174746163682e696e63223b693a323b733a32303a226669656c642e696e666f2e636c6173732e696e63223b693a333b733a31363a2274657374732f6669656c642e74657374223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31373a226669656c645f73716c5f73746f72616765223b7d733a383a227265717569726564223b623a313b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31353a227468656d652f6669656c642e637373223b733a32393a226d6f64756c65732f6669656c642f7468656d652f6669656c642e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/field_sql_storage/field_sql_storage.module', 'field_sql_storage', 'module', '', 1, 0, 7002, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a224669656c642053514c2073746f72616765223b733a31313a226465736372697074696f6e223b733a33373a2253746f726573206669656c64206461746120696e20616e2053514c2064617461626173652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a32323a226669656c645f73716c5f73746f726167652e74657374223b7d733a383a227265717569726564223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/list/list.module', 'list', 'module', '', 1, 0, 7002, 0, 0x613a31323a7b733a343a226e616d65223b733a343a224c697374223b733a31313a226465736372697074696f6e223b733a36393a22446566696e6573206c697374206669656c642074797065732e205573652077697468204f7074696f6e7320746f206372656174652073656c656374696f6e206c697374732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a353a226669656c64223b693a313b733a373a226f7074696f6e73223b7d733a353a2266696c6573223b613a313a7b693a303b733a31353a2274657374732f6c6973742e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/list/tests/list_test.module', 'list_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a224c6973742074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220746865204c697374206d6f64756c652074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/number/number.module', 'number', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a363a224e756d626572223b733a31313a226465736372697074696f6e223b733a32383a22446566696e6573206e756d65726963206669656c642074797065732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31313a226e756d6265722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/options/options.module', 'options', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a224f7074696f6e73223b733a31313a226465736372697074696f6e223b733a38323a22446566696e65732073656c656374696f6e2c20636865636b20626f7820616e6420726164696f20627574746f6e207769646765747320666f72207465787420616e64206e756d65726963206669656c64732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31323a226f7074696f6e732e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/text/text.module', 'text', 'module', '', 1, 0, 7000, 0, 0x613a31343a7b733a343a226e616d65223b733a343a2254657874223b733a31313a226465736372697074696f6e223b733a33323a22446566696e65732073696d706c652074657874206669656c642074797065732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a393a22746578742e74657374223b7d733a383a227265717569726564223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a31313a226578706c616e6174696f6e223b733a38353a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f6369766963726d546573742f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/field/tests/field_test.module', 'field_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a224669656c64204150492054657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220746865204669656c64204150492074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a353a2266696c6573223b613a313a7b693a303b733a32313a226669656c645f746573742e656e746974792e696e63223b7d733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field_ui/field_ui.module', 'field_ui', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a383a224669656c64205549223b733a31313a226465736372697074696f6e223b733a33333a225573657220696e7465726661636520666f7220746865204669656c64204150492e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31333a226669656c645f75692e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/file/file.module', 'file', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a343a2246696c65223b733a31313a226465736372697074696f6e223b733a32363a22446566696e657320612066696c65206669656c6420747970652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31353a2274657374732f66696c652e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/file/tests/file_module_test.module', 'file_module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2246696c652074657374223b733a31313a226465736372697074696f6e223b733a35333a2250726f766964657320686f6f6b7320666f722074657374696e672046696c65206d6f64756c652066756e6374696f6e616c6974792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/filter/filter.module', 'filter', 'module', '', 1, 0, 7010, 0, 0x613a31343a7b733a343a226e616d65223b733a363a2246696c746572223b733a31313a226465736372697074696f6e223b733a34333a2246696c7465727320636f6e74656e7420696e207072657061726174696f6e20666f7220646973706c61792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a2266696c7465722e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a32383a2261646d696e2f636f6e6669672f636f6e74656e742f666f726d617473223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/forum/forum.module', 'forum', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a353a22466f72756d223b733a31313a226465736372697074696f6e223b733a32373a2250726f76696465732064697363757373696f6e20666f72756d732e223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a383a227461786f6e6f6d79223b693a313b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22666f72756d2e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f666f72756d223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a393a22666f72756d2e637373223b733a32333a226d6f64756c65732f666f72756d2f666f72756d2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/help/help.module', 'help', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a343a2248656c70223b733a31313a226465736372697074696f6e223b733a33353a224d616e616765732074686520646973706c6179206f66206f6e6c696e652068656c702e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a2268656c702e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/image/image.module', 'image', 'module', '', 1, 0, 7005, 0, 0x613a31353a7b733a343a226e616d65223b733a353a22496d616765223b733a31313a226465736372697074696f6e223b733a33343a2250726f766964657320696d616765206d616e6970756c6174696f6e20746f6f6c732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a2266696c65223b7d733a353a2266696c6573223b613a313a7b693a303b733a31303a22696d6167652e74657374223b7d733a393a22636f6e666967757265223b733a33313a2261646d696e2f636f6e6669672f6d656469612f696d6167652d7374796c6573223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a383a227265717569726564223b623a313b733a31313a226578706c616e6174696f6e223b733a38353a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f6369766963726d546573742f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/image/tests/image_module_test.module', 'image_module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22496d6167652074657374223b733a31313a226465736372697074696f6e223b733a36393a2250726f766964657320686f6f6b20696d706c656d656e746174696f6e7320666f722074657374696e6720496d616765206d6f64756c652066756e6374696f6e616c6974792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a32343a22696d6167655f6d6f64756c655f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/locale/locale.module', 'locale', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a363a224c6f63616c65223b733a31313a226465736372697074696f6e223b733a3131393a2241646473206c616e67756167652068616e646c696e672066756e6374696f6e616c69747920616e6420656e61626c657320746865207472616e736c6174696f6e206f6620746865207573657220696e7465726661636520746f206c616e677561676573206f74686572207468616e20456e676c6973682e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a226c6f63616c652e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f636f6e6669672f726567696f6e616c2f6c616e6775616765223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/locale/tests/locale_test.module', 'locale_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a224c6f63616c652054657374223b733a31313a226465736372697074696f6e223b733a34323a22537570706f7274206d6f64756c6520666f7220746865206c6f63616c65206c617965722074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/menu/menu.module', 'menu', 'module', '', 1, 0, 7003, 0, 0x613a31333a7b733a343a226e616d65223b733a343a224d656e75223b733a31313a226465736372697074696f6e223b733a36303a22416c6c6f77732061646d696e6973747261746f727320746f20637573746f6d697a65207468652073697465206e617669676174696f6e206d656e752e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a226d656e752e74657374223b7d733a393a22636f6e666967757265223b733a32303a2261646d696e2f7374727563747572652f6d656e75223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/node/node.module', 'node', 'module', '', 1, 0, 7016, 0, 0x613a31353a7b733a343a226e616d65223b733a343a224e6f6465223b733a31313a226465736372697074696f6e223b733a36363a22416c6c6f777320636f6e74656e7420746f206265207375626d697474656420746f20746865207369746520616e6420646973706c61796564206f6e2070616765732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31313a226e6f64652e6d6f64756c65223b693a313b733a393a226e6f64652e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f7479706573223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a226e6f64652e637373223b733a32313a226d6f64756c65732f6e6f64652f6e6f64652e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_access_test.module', 'node_access_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a224e6f6465206d6f64756c6520616363657373207465737473223b733a31313a226465736372697074696f6e223b733a34333a22537570706f7274206d6f64756c6520666f72206e6f6465207065726d697373696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_test.module', 'node_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a224e6f6465206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72206e6f64652072656c617465642074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_test_exception.module', 'node_test_exception', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32373a224e6f6465206d6f64756c6520657863657074696f6e207465737473223b733a31313a226465736372697074696f6e223b733a35303a22537570706f7274206d6f64756c6520666f72206e6f64652072656c6174656420657863657074696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/openid/openid.module', 'openid', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a363a224f70656e4944223b733a31313a226465736372697074696f6e223b733a34383a22416c6c6f777320757365727320746f206c6f6720696e746f20796f75722073697465207573696e67204f70656e49442e223b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a227061636b616765223b733a343a22436f7265223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a226f70656e69642e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/openid/tests/openid_test.module', 'openid_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224f70656e49442064756d6d792070726f7669646572223b733a31313a226465736372697074696f6e223b733a33333a224f70656e49442070726f7669646572207573656420666f722074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a226f70656e6964223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/overlay/overlay.module', 'overlay', 'module', '', 0, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a224f7665726c6179223b733a31313a226465736372697074696f6e223b733a35393a22446973706c617973207468652044727570616c2061646d696e697374726174696f6e20696e7465726661636520696e20616e206f7665726c61792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/path/path.module', 'path', 'module', '', 1, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a343a2250617468223b733a31313a226465736372697074696f6e223b733a32383a22416c6c6f777320757365727320746f2072656e616d652055524c732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22706174682e74657374223b7d733a393a22636f6e666967757265223b733a32343a2261646d696e2f636f6e6669672f7365617263682f70617468223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/php/php.module', 'php', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31303a225048502066696c746572223b733a31313a226465736372697074696f6e223b733a35303a22416c6c6f777320656d6265646465642050485020636f64652f736e69707065747320746f206265206576616c75617465642e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a383a227068702e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/poll/poll.module', 'poll', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a343a22506f6c6c223b733a31313a226465736372697074696f6e223b733a39353a22416c6c6f777320796f7572207369746520746f206361707475726520766f746573206f6e20646966666572656e7420746f7069637320696e2074686520666f726d206f66206d756c7469706c652063686f696365207175657374696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22706f6c6c2e74657374223b7d733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22706f6c6c2e637373223b733a32313a226d6f64756c65732f706f6c6c2f706f6c6c2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/profile/profile.module', 'profile', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a373a2250726f66696c65223b733a31313a226465736372697074696f6e223b733a33363a22537570706f72747320636f6e666967757261626c6520757365722070726f66696c65732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a2270726f66696c652e74657374223b7d733a393a22636f6e666967757265223b733a32373a2261646d696e2f636f6e6669672f70656f706c652f70726f66696c65223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/rdf/rdf.module', 'rdf', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a333a22524446223b733a31313a226465736372697074696f6e223b733a3134383a22456e72696368657320796f757220636f6e74656e742077697468206d6574616461746120746f206c6574206f74686572206170706c69636174696f6e732028652e672e2073656172636820656e67696e65732c2061676772656761746f7273292062657474657220756e6465727374616e64206974732072656c6174696f6e736869707320616e6420617474726962757465732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a383a227264662e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/rdf/tests/rdf_test.module', 'rdf_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a22524446206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a33383a22537570706f7274206d6f64756c6520666f7220524446206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a22626c6f67223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/search.module', 'search', 'module', '', 1, 0, 7000, 0, 0x613a31343a7b733a343a226e616d65223b733a363a22536561726368223b733a31313a226465736372697074696f6e223b733a33363a22456e61626c657320736974652d77696465206b6579776f726420736561726368696e672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31393a227365617263682e657874656e6465722e696e63223b693a313b733a31313a227365617263682e74657374223b7d733a393a22636f6e666967757265223b733a32383a2261646d696e2f636f6e6669672f7365617263682f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a227365617263682e637373223b733a32353a226d6f64756c65732f7365617263682f7365617263682e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_embedded_form.module', 'search_embedded_form', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32303a2253656172636820656d62656464656420666f726d223b733a31313a226465736372697074696f6e223b733a35393a22537570706f7274206d6f64756c6520666f7220736561726368206d6f64756c652074657374696e67206f6620656d62656464656420666f726d732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_extra_type.module', 'search_extra_type', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a2254657374207365617263682074797065223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220736561726368206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_node_tags.module', 'search_node_tags', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a225465737420736561726368206e6f64652074616773223b733a31313a226465736372697074696f6e223b733a34343a22537570706f7274206d6f64756c6520666f72204e6f64652073656172636820746167732074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/shortcut/shortcut.module', 'shortcut', 'module', '', 1, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a383a2253686f7274637574223b733a31313a226465736372697074696f6e223b733a36303a22416c6c6f777320757365727320746f206d616e61676520637573746f6d697a61626c65206c69737473206f662073686f7274637574206c696e6b732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31333a2273686f72746375742e74657374223b7d733a393a22636f6e666967757265223b733a33363a2261646d696e2f636f6e6669672f757365722d696e746572666163652f73686f7274637574223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d);
INSERT INTO `system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/simpletest/simpletest.module', 'simpletest', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a2254657374696e67223b733a31313a226465736372697074696f6e223b733a35333a2250726f76696465732061206672616d65776f726b20666f7220756e697420616e642066756e6374696f6e616c2074657374696e672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a35303a7b693a303b733a31353a2273696d706c65746573742e74657374223b693a313b733a32343a2264727570616c5f7765625f746573745f636173652e706870223b693a323b733a31383a2274657374732f616374696f6e732e74657374223b693a333b733a31353a2274657374732f616a61782e74657374223b693a343b733a31363a2274657374732f62617463682e74657374223b693a353b733a31353a2274657374732f626f6f742e74657374223b693a363b733a32303a2274657374732f626f6f7473747261702e74657374223b693a373b733a31363a2274657374732f63616368652e74657374223b693a383b733a31373a2274657374732f636f6d6d6f6e2e74657374223b693a393b733a32343a2274657374732f64617461626173655f746573742e74657374223b693a31303b733a32323a2274657374732f656e746974795f637275642e74657374223b693a31313b733a33323a2274657374732f656e746974795f637275645f686f6f6b5f746573742e74657374223b693a31323b733a32333a2274657374732f656e746974795f71756572792e74657374223b693a31333b733a31363a2274657374732f6572726f722e74657374223b693a31343b733a31353a2274657374732f66696c652e74657374223b693a31353b733a32333a2274657374732f66696c657472616e736665722e74657374223b693a31363b733a31353a2274657374732f666f726d2e74657374223b693a31373b733a31363a2274657374732f67726170682e74657374223b693a31383b733a31363a2274657374732f696d6167652e74657374223b693a31393b733a31353a2274657374732f6c6f636b2e74657374223b693a32303b733a31353a2274657374732f6d61696c2e74657374223b693a32313b733a31353a2274657374732f6d656e752e74657374223b693a32323b733a31373a2274657374732f6d6f64756c652e74657374223b693a32333b733a31363a2274657374732f70616765722e74657374223b693a32343b733a31393a2274657374732f70617373776f72642e74657374223b693a32353b733a31353a2274657374732f706174682e74657374223b693a32363b733a31393a2274657374732f72656769737472792e74657374223b693a32373b733a31373a2274657374732f736368656d612e74657374223b693a32383b733a31383a2274657374732f73657373696f6e2e74657374223b693a32393b733a32303a2274657374732f7461626c65736f72742e74657374223b693a33303b733a31363a2274657374732f7468656d652e74657374223b693a33313b733a31383a2274657374732f756e69636f64652e74657374223b693a33323b733a31373a2274657374732f7570646174652e74657374223b693a33333b733a31373a2274657374732f786d6c7270632e74657374223b693a33343b733a32363a2274657374732f757067726164652f757067726164652e74657374223b693a33353b733a33343a2274657374732f757067726164652f757067726164652e636f6d6d656e742e74657374223b693a33363b733a33333a2274657374732f757067726164652f757067726164652e66696c7465722e74657374223b693a33373b733a33323a2274657374732f757067726164652f757067726164652e666f72756d2e74657374223b693a33383b733a33333a2274657374732f757067726164652f757067726164652e6c6f63616c652e74657374223b693a33393b733a33313a2274657374732f757067726164652f757067726164652e6d656e752e74657374223b693a34303b733a33313a2274657374732f757067726164652f757067726164652e6e6f64652e74657374223b693a34313b733a33353a2274657374732f757067726164652f757067726164652e7461786f6e6f6d792e74657374223b693a34323b733a33343a2274657374732f757067726164652f757067726164652e747269676765722e74657374223b693a34333b733a33393a2274657374732f757067726164652f757067726164652e7472616e736c617461626c652e74657374223b693a34343b733a33333a2274657374732f757067726164652f757067726164652e75706c6f61642e74657374223b693a34353b733a33313a2274657374732f757067726164652f757067726164652e757365722e74657374223b693a34363b733a33363a2274657374732f757067726164652f7570646174652e61676772656761746f722e74657374223b693a34373b733a33333a2274657374732f757067726164652f7570646174652e747269676765722e74657374223b693a34383b733a33313a2274657374732f757067726164652f7570646174652e6669656c642e74657374223b693a34393b733a33303a2274657374732f757067726164652f7570646174652e757365722e74657374223b7d733a393a22636f6e666967757265223b733a34313a2261646d696e2f636f6e6669672f646576656c6f706d656e742f74657374696e672f73657474696e6773223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/actions_loop_test.module', 'actions_loop_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a22416374696f6e73206c6f6f702074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220616374696f6e206c6f6f702074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/ajax_forms_test.module', 'ajax_forms_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32363a22414a415820666f726d2074657374206d6f636b206d6f64756c65223b733a31313a226465736372697074696f6e223b733a32353a225465737420666f7220414a415820666f726d2063616c6c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/ajax_test.module', 'ajax_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a22414a41582054657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f7220414a4158206672616d65776f726b2074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/batch_test.module', 'batch_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a224261746368204150492074657374223b733a31313a226465736372697074696f6e223b733a33353a22537570706f7274206d6f64756c6520666f72204261746368204150492074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/boot_test_1.module', 'boot_test_1', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224561726c7920626f6f747374726170207465737473223b733a31313a226465736372697074696f6e223b733a33393a224120737570706f7274206d6f64756c6520666f7220686f6f6b5f626f6f742074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/boot_test_2.module', 'boot_test_2', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224561726c7920626f6f747374726170207465737473223b733a31313a226465736372697074696f6e223b733a34343a224120737570706f7274206d6f64756c6520666f7220686f6f6b5f626f6f7420686f6f6b2074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/common_test.module', 'common_test', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a31313a22436f6d6d6f6e2054657374223b733a31313a226465736372697074696f6e223b733a33323a22537570706f7274206d6f64756c6520666f7220436f6d6d6f6e2074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a31353a22636f6d6d6f6e5f746573742e637373223b733a34303a226d6f64756c65732f73696d706c65746573742f74657374732f636f6d6d6f6e5f746573742e637373223b7d733a353a227072696e74223b613a313a7b733a32313a22636f6d6d6f6e5f746573742e7072696e742e637373223b733a34363a226d6f64756c65732f73696d706c65746573742f74657374732f636f6d6d6f6e5f746573742e7072696e742e637373223b7d7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/common_test_cron_helper.module', 'common_test_cron_helper', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32333a22436f6d6d6f6e20546573742043726f6e2048656c706572223b733a31313a226465736372697074696f6e223b733a35363a2248656c706572206d6f64756c6520666f722043726f6e52756e54657374436173653a3a7465737443726f6e457863657074696f6e7328292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/database_test.module', 'database_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31333a2244617461626173652054657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72204461746162617365206c617965722074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_autoload_test/drupal_autoload_test.module', 'drupal_autoload_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32353a2244727570616c20636f64652072656769737472792074657374223b733a31313a226465736372697074696f6e223b733a34353a22537570706f7274206d6f64756c6520666f722074657374696e672074686520636f64652072656769737472792e223b733a353a2266696c6573223b613a323a7b693a303b733a33343a2264727570616c5f6175746f6c6f61645f746573745f696e746572666163652e696e63223b693a313b733a33303a2264727570616c5f6175746f6c6f61645f746573745f636c6173732e696e63223b7d733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module', 'drupal_system_listing_compatible_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33373a2244727570616c2073797374656d206c697374696e6720636f6d70617469626c652074657374223b733a31313a226465736372697074696f6e223b733a36323a22537570706f7274206d6f64756c6520666f722074657374696e67207468652064727570616c5f73797374656d5f6c697374696e672066756e6374696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module', 'drupal_system_listing_incompatible_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33393a2244727570616c2073797374656d206c697374696e6720696e636f6d70617469626c652074657374223b733a31313a226465736372697074696f6e223b733a36323a22537570706f7274206d6f64756c6520666f722074657374696e67207468652064727570616c5f73797374656d5f6c697374696e672066756e6374696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_cache_test.module', 'entity_cache_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a22456e746974792063616368652074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f722074657374696e6720656e746974792063616368652e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a32383a22656e746974795f63616368655f746573745f646570656e64656e6379223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_cache_test_dependency.module', 'entity_cache_test_dependency', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32383a22456e74697479206361636865207465737420646570656e64656e6379223b733a31313a226465736372697074696f6e223b733a35313a22537570706f727420646570656e64656e6379206d6f64756c6520666f722074657374696e6720656e746974792063616368652e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_crud_hook_test.module', 'entity_crud_hook_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a22456e74697479204352554420486f6f6b732054657374223b733a31313a226465736372697074696f6e223b733a33353a22537570706f7274206d6f64756c6520666f72204352554420686f6f6b2074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_query_access_test.module', 'entity_query_access_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a22456e74697479207175657279206163636573732074657374223b733a31313a226465736372697074696f6e223b733a34393a22537570706f7274206d6f64756c6520666f7220636865636b696e6720656e7469747920717565727920726573756c74732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/error_test.module', 'error_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a224572726f722074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f72206572726f7220616e6420657863657074696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/file_test.module', 'file_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2246696c652074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f722066696c652068616e646c696e672074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31363a2266696c655f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/filter_test.module', 'filter_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31383a2246696c7465722074657374206d6f64756c65223b733a31313a226465736372697074696f6e223b733a33333a2254657374732066696c74657220686f6f6b7320616e642066756e6374696f6e732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/form_test.module', 'form_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22466f726d4150492054657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f7220466f726d204150492074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/image_test.module', 'image_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22496d6167652074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220696d61676520746f6f6c6b69742074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/menu_test.module', 'menu_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22486f6f6b206d656e75207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72206d656e7520686f6f6b2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/module_test.module', 'module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a224d6f64756c652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f72206d6f64756c652073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/path_test.module', 'path_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22486f6f6b2070617468207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72207061746820686f6f6b2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/psr_0_test/psr_0_test.module', 'psr_0_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a225053522d302054657374206361736573223b733a31313a226465736372697074696f6e223b733a34343a225465737420636c617373657320746f20626520646973636f76657265642062792073696d706c65746573742e223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/psr_4_test/psr_4_test.module', 'psr_4_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a225053522d342054657374206361736573223b733a31313a226465736372697074696f6e223b733a34343a225465737420636c617373657320746f20626520646973636f76657265642062792073696d706c65746573742e223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/requirements1_test.module', 'requirements1_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31393a22526571756972656d656e747320312054657374223b733a31313a226465736372697074696f6e223b733a38303a22546573747320746861742061206d6f64756c65206973206e6f7420696e7374616c6c6564207768656e206974206661696c7320686f6f6b5f726571756972656d656e74732827696e7374616c6c27292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/requirements2_test.module', 'requirements2_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31393a22526571756972656d656e747320322054657374223b733a31313a226465736372697074696f6e223b733a39383a22546573747320746861742061206d6f64756c65206973206e6f7420696e7374616c6c6564207768656e20746865206f6e6520697420646570656e6473206f6e206661696c7320686f6f6b5f726571756972656d656e74732827696e7374616c6c292e223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a31383a22726571756972656d656e7473315f74657374223b693a313b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/session_test.module', 'session_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a2253657373696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f722073657373696f6e20646174612074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_dependencies_test.module', 'system_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a2253797374656d20646570656e64656e63792074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31393a225f6d697373696e675f646570656e64656e6379223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_core_version_dependencies_test.module', 'system_incompatible_core_version_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a35303a2253797374656d20696e636f6d70617469626c6520636f72652076657273696f6e20646570656e64656e636965732074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a33373a2273797374656d5f696e636f6d70617469626c655f636f72655f76657273696f6e5f74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_core_version_test.module', 'system_incompatible_core_version_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33373a2253797374656d20696e636f6d70617469626c6520636f72652076657273696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22352e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_module_version_dependencies_test.module', 'system_incompatible_module_version_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a35323a2253797374656d20696e636f6d70617469626c65206d6f64756c652076657273696f6e20646570656e64656e636965732074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a34363a2273797374656d5f696e636f6d70617469626c655f6d6f64756c655f76657273696f6e5f7465737420283e322e3029223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_module_version_test.module', 'system_incompatible_module_version_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33393a2253797374656d20696e636f6d70617469626c65206d6f64756c652076657273696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_project_namespace_test.module', 'system_project_namespace_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32393a2253797374656d2070726f6a656374206e616d6573706163652074657374223b733a31313a226465736372697074696f6e223b733a35383a22537570706f7274206d6f64756c6520666f722074657374696e672070726f6a656374206e616d65737061636520646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31333a2264727570616c3a66696c746572223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_test.module', 'system_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a2253797374656d2074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f722073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31383a2273797374656d5f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/taxonomy_test.module', 'taxonomy_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32303a225461786f6e6f6d792074657374206d6f64756c65223b733a31313a226465736372697074696f6e223b733a34353a222254657374732066756e6374696f6e7320616e6420686f6f6b73206e6f74207573656420696e20636f7265222e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a383a227461786f6e6f6d79223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/theme_test.module', 'theme_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a225468656d652074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72207468656d652073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_script_test.module', 'update_script_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31383a22557064617465207363726970742074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465207363726970742074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_1.module', 'update_test_1', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_2.module', 'update_test_2', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_3.module', 'update_test_3', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/url_alter_test.module', 'url_alter_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a2255726c5f616c746572207465737473223b733a31313a226465736372697074696f6e223b733a34353a224120737570706f7274206d6f64756c657320666f722075726c5f616c74657220686f6f6b2074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/xmlrpc_test.module', 'xmlrpc_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22584d4c2d5250432054657374223b733a31313a226465736372697074696f6e223b733a37353a22537570706f7274206d6f64756c6520666f7220584d4c2d525043207465737473206163636f7264696e6720746f207468652076616c696461746f72312073706563696669636174696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/statistics/statistics.module', 'statistics', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a2253746174697374696373223b733a31313a226465736372697074696f6e223b733a33373a224c6f677320616363657373207374617469737469637320666f7220796f757220736974652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a22737461746973746963732e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f636f6e6669672f73797374656d2f73746174697374696373223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/syslog/syslog.module', 'syslog', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a363a225379736c6f67223b733a31313a226465736372697074696f6e223b733a34313a224c6f677320616e64207265636f7264732073797374656d206576656e747320746f207379736c6f672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a227379736c6f672e74657374223b7d733a393a22636f6e666967757265223b733a33323a2261646d696e2f636f6e6669672f646576656c6f706d656e742f6c6f6767696e67223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/system/system.module', 'system', 'module', '', 1, 0, 7081, 0, 0x613a31343a7b733a343a226e616d65223b733a363a2253797374656d223b733a31313a226465736372697074696f6e223b733a35343a2248616e646c65732067656e6572616c207369746520636f6e66696775726174696f6e20666f722061646d696e6973747261746f72732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a363a7b693a303b733a31393a2273797374656d2e61726368697665722e696e63223b693a313b733a31353a2273797374656d2e6d61696c2e696e63223b693a323b733a31363a2273797374656d2e71756575652e696e63223b693a333b733a31343a2273797374656d2e7461722e696e63223b693a343b733a31383a2273797374656d2e757064617465722e696e63223b693a353b733a31313a2273797374656d2e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a31393a2261646d696e2f636f6e6669672f73797374656d223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/system/tests/cron_queue_test.module', 'cron_queue_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a2243726f6e2051756575652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f72207468652063726f6e2071756575652072756e6e65722e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/system/tests/system_cron_test.module', 'system_cron_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a2253797374656d2043726f6e2054657374223b733a31313a226465736372697074696f6e223b733a34353a22537570706f7274206d6f64756c6520666f722074657374696e67207468652073797374656d5f63726f6e28292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d);
INSERT INTO `system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/taxonomy/taxonomy.module', 'taxonomy', 'module', '', 1, 0, 7011, 0, 0x613a31353a7b733a343a226e616d65223b733a383a225461786f6e6f6d79223b733a31313a226465736372697074696f6e223b733a33383a22456e61626c6573207468652063617465676f72697a6174696f6e206f6620636f6e74656e742e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a226f7074696f6e73223b7d733a353a2266696c6573223b613a323a7b693a303b733a31353a227461786f6e6f6d792e6d6f64756c65223b693a313b733a31333a227461786f6e6f6d792e74657374223b7d733a393a22636f6e666967757265223b733a32343a2261646d696e2f7374727563747572652f7461786f6e6f6d79223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a383a227265717569726564223b623a313b733a31313a226578706c616e6174696f6e223b733a38353a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f6369766963726d546573742f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/toolbar/toolbar.module', 'toolbar', 'module', '', 0, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a22546f6f6c626172223b733a31313a226465736372697074696f6e223b733a39393a2250726f7669646573206120746f6f6c62617220746861742073686f77732074686520746f702d6c6576656c2061646d696e697374726174696f6e206d656e75206974656d7320616e64206c696e6b732066726f6d206f74686572206d6f64756c65732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/tracker/tracker.module', 'tracker', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a373a22547261636b6572223b733a31313a226465736372697074696f6e223b733a34353a22456e61626c657320747261636b696e67206f6620726563656e7420636f6e74656e7420666f722075736572732e223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22747261636b65722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/translation/tests/translation_test.module', 'translation_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a22436f6e74656e74205472616e736c6174696f6e2054657374223b733a31313a226465736372697074696f6e223b733a34393a22537570706f7274206d6f64756c6520666f722074686520636f6e74656e74207472616e736c6174696f6e2074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/translation/translation.module', 'translation', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31393a22436f6e74656e74207472616e736c6174696f6e223b733a31313a226465736372697074696f6e223b733a35373a22416c6c6f777320636f6e74656e7420746f206265207472616e736c6174656420696e746f20646966666572656e74206c616e6775616765732e223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a226c6f63616c65223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31363a227472616e736c6174696f6e2e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/trigger/tests/trigger_test.module', 'trigger_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22547269676765722054657374223b733a31313a226465736372697074696f6e223b733a33333a22537570706f7274206d6f64756c6520666f7220547269676765722074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/trigger/trigger.module', 'trigger', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a2254726967676572223b733a31313a226465736372697074696f6e223b733a39303a22456e61626c657320616374696f6e7320746f206265206669726564206f6e206365727461696e2073797374656d206576656e74732c2073756368206173207768656e206e657720636f6e74656e7420697320637265617465642e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22747269676765722e74657374223b7d733a393a22636f6e666967757265223b733a32333a2261646d696e2f7374727563747572652f74726967676572223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/aaa_update_test.module', 'aaa_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22414141205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/bbb_update_test.module', 'bbb_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22424242205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/ccc_update_test.module', 'ccc_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22434343205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/update_test.module', 'update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/update.module', 'update', 'module', '', 1, 0, 7001, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a22557064617465206d616e61676572223b733a31313a226465736372697074696f6e223b733a3130343a22436865636b7320666f7220617661696c61626c6520757064617465732c20616e642063616e207365637572656c7920696e7374616c6c206f7220757064617465206d6f64756c657320616e64207468656d65732076696120612077656220696e746572666163652e223b733a373a2276657273696f6e223b733a343a22372e3531223b733a373a227061636b616765223b733a343a22436f7265223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a227570646174652e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f7265706f7274732f757064617465732f73657474696e6773223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/user/tests/user_form_test.module', 'user_form_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a2255736572206d6f64756c6520666f726d207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72207573657220666f726d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/user/user.module', 'user', 'module', '', 1, 0, 7019, 0, 0x613a31353a7b733a343a226e616d65223b733a343a2255736572223b733a31313a226465736372697074696f6e223b733a34373a224d616e6167657320746865207573657220726567697374726174696f6e20616e64206c6f67696e2073797374656d2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31313a22757365722e6d6f64756c65223b693a313b733a393a22757365722e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a31393a2261646d696e2f636f6e6669672f70656f706c65223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22757365722e637373223b733a32313a226d6f64756c65732f757365722f757365722e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('profiles/standard/standard.profile', 'standard', 'module', '', 1, 0, 0, 1000, 0x613a31353a7b733a343a226e616d65223b733a383a225374616e64617264223b733a31313a226465736372697074696f6e223b733a35313a22496e7374616c6c207769746820636f6d6d6f6e6c792075736564206665617475726573207072652d636f6e666967757265642e223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a32313a7b693a303b733a353a22626c6f636b223b693a313b733a353a22636f6c6f72223b693a323b733a373a22636f6d6d656e74223b693a333b733a31303a22636f6e7465787475616c223b693a343b733a393a2264617368626f617264223b693a353b733a343a2268656c70223b693a363b733a353a22696d616765223b693a373b733a343a226c697374223b693a383b733a343a226d656e75223b693a393b733a363a226e756d626572223b693a31303b733a373a226f7074696f6e73223b693a31313b733a343a2270617468223b693a31323b733a383a227461786f6e6f6d79223b693a31333b733a353a2264626c6f67223b693a31343b733a363a22736561726368223b693a31353b733a383a2273686f7274637574223b693a31363b733a373a22746f6f6c626172223b693a31373b733a373a226f7665726c6179223b693a31383b733a383a226669656c645f7569223b693a31393b733a343a2266696c65223b693a32303b733a333a22726466223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a353a226d74696d65223b693a313437353639343137343b733a373a227061636b616765223b733a353a224f74686572223b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b733a363a2268696464656e223b623a313b733a383a227265717569726564223b623a313b733a31373a22646973747269627574696f6e5f6e616d65223b733a363a2244727570616c223b7d),
('sites/all/modules/admin_menu/admin_devel/admin_devel.module', 'admin_devel', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33323a2241646d696e697374726174696f6e20446576656c6f706d656e7420746f6f6c73223b733a31313a226465736372697074696f6e223b733a37363a2241646d696e697374726174696f6e20616e6420646562756767696e672066756e6374696f6e616c69747920666f7220646576656c6f7065727320616e642073697465206275696c646572732e223b733a373a227061636b616765223b733a31343a2241646d696e697374726174696f6e223b733a343a22636f7265223b733a333a22372e78223b733a373a2273637269707473223b613a313a7b733a31343a2261646d696e5f646576656c2e6a73223b733a35353a2273697465732f616c6c2f6d6f64756c65732f61646d696e5f6d656e752f61646d696e5f646576656c2f61646d696e5f646576656c2e6a73223b7d733a373a2276657273696f6e223b733a31313a22372e782d332e302d726335223b733a373a2270726f6a656374223b733a31303a2261646d696e5f6d656e75223b733a393a22646174657374616d70223b733a31303a2231343139303239323834223b733a353a226d74696d65223b693a313431393032393238343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/admin_menu/admin_menu.module', 'admin_menu', 'module', '', 1, 0, 7304, 100, 0x613a31333a7b733a343a226e616d65223b733a31393a2241646d696e697374726174696f6e206d656e75223b733a31313a226465736372697074696f6e223b733a3132333a2250726f766964657320612064726f70646f776e206d656e7520746f206d6f73742061646d696e697374726174697665207461736b7320616e64206f7468657220636f6d6d6f6e2064657374696e6174696f6e732028746f2075736572732077697468207468652070726f706572207065726d697373696f6e73292e223b733a373a227061636b616765223b733a31343a2241646d696e697374726174696f6e223b733a343a22636f7265223b733a333a22372e78223b733a393a22636f6e666967757265223b733a33383a2261646d696e2f636f6e6669672f61646d696e697374726174696f6e2f61646d696e5f6d656e75223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31343a2273797374656d20283e372e313029223b7d733a353a2266696c6573223b613a313a7b693a303b733a32313a2274657374732f61646d696e5f6d656e752e74657374223b7d733a373a2276657273696f6e223b733a31313a22372e782d332e302d726335223b733a373a2270726f6a656374223b733a31303a2261646d696e5f6d656e75223b733a393a22646174657374616d70223b733a31303a2231343139303239323834223b733a353a226d74696d65223b693a313431393032393238343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/admin_menu/admin_menu_toolbar/admin_menu_toolbar.module', 'admin_menu_toolbar', 'module', '', 1, 0, 6300, 101, 0x613a31323a7b733a343a226e616d65223b733a33333a2241646d696e697374726174696f6e206d656e7520546f6f6c626172207374796c65223b733a31313a226465736372697074696f6e223b733a31373a22412062657474657220546f6f6c6261722e223b733a373a227061636b616765223b733a31343a2241646d696e697374726174696f6e223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31303a2261646d696e5f6d656e75223b7d733a373a2276657273696f6e223b733a31313a22372e782d332e302d726335223b733a373a2270726f6a656374223b733a31303a2261646d696e5f6d656e75223b733a393a22646174657374616d70223b733a31303a2231343139303239323834223b733a353a226d74696d65223b693a313431393032393238343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/civicrm/drupal/civicrm.module', 'civicrm', 'module', '', 1, 0, 7401, 100, 0x613a31313a7b733a343a226e616d65223b733a373a224369766943524d223b733a31313a226465736372697074696f6e223b733a3235323a22436f6e7374697475656e742072656c6174696f6e73686970206d616e6167656d656e742073797374656d2e20416c6c6f777320736974657320746f206d616e61676520636f6e74616374732c2072656c6174696f6e736869707320616e642067726f7570732c20616e6420747261636b20636f6e7461637420616374697669746965732c20636f6e747269627574696f6e732c206d656d626572736869707320616e64206576656e74732e2053656520746865203c6120687265663d2268747470733a2f2f6369766963726d2e6f72672f223e4369766943524d20776562736974653c2f613e20666f72206d6f726520696e666f726d6174696f6e2e223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a373a227061636b616765223b733a373a224369766943524d223b733a343a22636f7265223b733a333a22372e78223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a333a22706870223b733a333a22352e33223b733a353a2266696c6573223b613a36383a7b693a303b733a31343a226369766963726d2e6d6f64756c65223b693a313b733a31353a226369766963726d2e696e7374616c6c223b693a323b733a31363a226369766963726d5f757365722e696e63223b693a333b733a33313a226d6f64756c65732f76696577732f6369766963726d2e76696577732e696e63223b693a343b733a33393a226d6f64756c65732f76696577732f6369766963726d2e76696577735f64656661756c742e696e63223b693a353b733a34373a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c642e696e63223b693a363b733a36333a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f70736575646f5f636f6e7374616e742e696e63223b693a373b733a35353a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f616464726573732e696e63223b693a383b733a35373a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f636f6d706f6e656e742e696e63223b693a393b733a36303a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f636f6e746163745f6c696e6b2e696e63223b693a31303b733a35343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f636f756e74792e696e63223b693a31313b733a35353a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f636f756e7472792e696e63223b693a31323b733a35343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f637573746f6d2e696e63223b693a31333b733a35363a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6461746574696d652e696e63223b693a31343b733a35363a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f64727570616c69642e696e63223b693a31353b733a35333a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f656d61696c2e696e63223b693a31363b733a36343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f656e636f756e7465725f6d656469756d2e696e63223b693a31373b733a35333a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6576656e742e696e63223b693a31383b733a35383a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6576656e745f6c696e6b2e696e63223b693a31393b733a35323a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f66696c652e696e63223b693a32303b733a35323a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b2e696e63223b693a32313b733a36313a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f61637469766974792e696e63223b693a32323b733a36303a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f636f6e746163742e696e63223b693a32333b733a36353a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f636f6e747269627574696f6e2e696e63223b693a32343b733a35393a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f64656c6574652e696e63223b693a32353b733a35373a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f656469742e696e63223b693a32363b733a35383a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f6576656e742e696e63223b693a32373b733a36343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f7061727469636970616e742e696e63223b693a32383b733a35363a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f7063702e696e63223b693a32393b733a36353a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c696e6b5f72656c6174696f6e736869702e696e63223b693a33303b733a35363a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6c6f636174696f6e2e696e63223b693a33313b733a35323a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6d61696c2e696e63223b693a33323b733a35343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6d61726b75702e696e63223b693a33333b733a35333a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6d6f6e65792e696e63223b693a33343b733a35343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f6f7074696f6e2e696e63223b693a33353b733a36353a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f7063705f7261697365645f616d6f756e742e696e63223b693a33363b733a35333a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f70686f6e652e696e63223b693a33373b733a36353a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f72656c6174696f6e736869705f747970652e696e63223b693a33383b733a35333a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f73746174652e696e63223b693a33393b733a35393a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f637573746f6d5f66696c652e696e63223b693a34303b733a36313a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f636f6e746163745f696d6167652e696e63223b693a34313b733a36343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f70736575646f5f636f6e7374616e742e696e63223b693a34323b733a36323a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f637573746f6d5f6f7074696f6e2e696e63223b693a34333b733a35373a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f6461746574696d652e696e63223b693a34343b733a36353a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f656e636f756e7465725f6d656469756d2e696e63223b693a34353b733a36313a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f67726f75705f7374617475732e696e63223b693a34363b733a36323a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f637573746f6d5f6f7074696f6e2e696e63223b693a34373b733a36393a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f637573746f6d5f73696e676c655f6f7074696f6e2e696e63223b693a34383b733a36363a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f72656c6174696f6e736869705f747970652e696e63223b693a34393b733a36323a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f636f756e7472795f6d756c74692e696e63223b693a35303b733a36303a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f73746174655f6d756c74692e696e63223b693a35313b733a35353a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f66696c7465725f646f6d61696e2e696e63223b693a35323b733a35363a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f6669656c645f61637469766974792e696e63223b693a35333b733a35313a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f736f72745f646174652e696e63223b693a35343b733a36343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f736f72745f7063705f7261697365645f616d6f756e742e696e63223b693a35353b733a35373a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f706c7567696e5f617267756d656e745f64656661756c742e696e63223b693a35363b733a36303a226d6f64756c65732f76696577732f6369766963726d2f76696577735f68616e646c65725f617267756d656e745f6369766963726d5f6461792e696e63223b693a35373b733a36353a226d6f64756c65732f76696577732f6369766963726d2f76696577735f68616e646c65725f617267756d656e745f6369766963726d5f66756c6c646174652e696e63223b693a35383b733a36323a226d6f64756c65732f76696577732f6369766963726d2f76696577735f68616e646c65725f617267756d656e745f6369766963726d5f6d6f6e74682e696e63223b693a35393b733a36313a226d6f64756c65732f76696577732f6369766963726d2f76696577735f68616e646c65725f617267756d656e745f6369766963726d5f7765656b2e696e63223b693a36303b733a36313a226d6f64756c65732f76696577732f6369766963726d2f76696577735f68616e646c65725f617267756d656e745f6369766963726d5f796561722e696e63223b693a36313b733a36373a226d6f64756c65732f76696577732f6369766963726d2f76696577735f68616e646c65725f617267756d656e745f6369766963726d5f796561725f6d6f6e74682e696e63223b693a36323b733a35343a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f72656c6174696f6e736869702e696e63223b693a36333b733a36373a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f72656c6174696f6e736869705f72656c6174696f6e736869702e696e63223b693a36343b733a36383a226d6f64756c65732f76696577732f6369766963726d2f6369766963726d5f68616e646c65725f72656c6174696f6e736869705f636f6e746163743275736572732e696e63223b693a36353b733a35333a226d6f64756c65732f76696577732f706c7567696e732f63616c656e6461725f706c7567696e5f726f775f6369766963726d2e696e63223b693a36363b733a35393a226d6f64756c65732f76696577732f706c7567696e732f63616c656e6461725f706c7567696e5f726f775f6369766963726d5f6576656e742e696e63223b693a36373b733a36383a226d6f64756c65732f76696577732f706c7567696e732f6369766963726d5f706c7567696e5f617267756d656e745f64656661756c745f6369766963726d5f69642e696e63223b7d733a353a226d74696d65223b693a313437353634343230383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/civicrm/drupal/modules/civicrmtheme/civicrmtheme.module', 'civicrmtheme', 'module', '', 1, 0, 0, 110, 0x613a31313a7b733a343a226e616d65223b733a31333a224369766943524d205468656d65223b733a31313a226465736372697074696f6e223b733a33363a22446566696e6520616c7465726e617465207468656d657320666f72204369766943524d2e223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a224369766943524d223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a226369766963726d223b7d733a353a2266696c6573223b613a323a7b693a303b733a31393a226369766963726d7468656d652e6d6f64756c65223b693a313b733a32303a226369766963726d7468656d652e696e7374616c6c223b7d733a353a226d74696d65223b693a313437353634343230383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/civicrm/drupal/modules/civicrm_contact_ref/civicrm_contact_ref.module', 'civicrm_contact_ref', 'module', '', 0, 0, -1, 0, 0x613a31313a7b733a343a226e616d65223b733a33313a224369766943524d20436f6e74616374205265666572656e6365204669656c64223b733a31313a226465736372697074696f6e223b733a34303a224d616b65732061204369766943524d20436f6e74616374205265666572656e6365204669656c642e223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a224369766943524d223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a31323a22646570656e64656e63696573223b613a333a7b693a303b733a373a226369766963726d223b693a313b733a343a2274657874223b693a323b733a343a226c697374223b7d733a353a2266696c6573223b613a333a7b693a303b733a32373a226369766963726d5f636f6e746163745f7265662e696e7374616c6c223b693a313b733a32363a226369766963726d5f636f6e746163745f7265662e6d6f64756c65223b693a323b733a32393a226369766963726d5f636f6e746163745f7265662e66656564732e696e63223b7d733a353a226d74696d65223b693a313437353634343230383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/civicrm/drupal/modules/civicrm_engage/civicrm_engage.module', 'civicrm_engage', 'module', '', 0, 0, -1, 0, 0x613a31313a7b733a343a226e616d65223b733a31303a2243697669456e67616765223b733a31313a226465736372697074696f6e223b733a34373a2257616c6b6c69737420616e642050686f6e652d62616e6b696e6720737570706f727420666f72204369766943524d2e223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a224369766943524d223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a226369766963726d223b7d733a353a2266696c6573223b613a313a7b693a303b733a32313a226369766963726d5f656e676167652e6d6f64756c65223b7d733a353a226d74696d65223b693a313437353634343230383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/civicrm/drupal/modules/civicrm_group_roles/civicrm_group_roles.module', 'civicrm_group_roles', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a32303a224369766947726f757020526f6c65732053796e63223b733a31313a226465736372697074696f6e223b733a33363a2253796e632044727570616c20526f6c657320746f204369766943524d2047726f7570732e223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a224369766943524d223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a393a22636f6e666967757265223b733a34303a2261646d696e2f636f6e6669672f6369766963726d2f6369766963726d5f67726f75705f726f6c6573223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a226369766963726d223b7d733a353a2266696c6573223b613a323a7b693a303b733a32363a226369766963726d5f67726f75705f726f6c65732e6d6f64756c65223b693a313b733a32373a226369766963726d5f67726f75705f726f6c65732e696e7374616c6c223b7d733a353a226d74696d65223b693a313437353634343230383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/civicrm/drupal/modules/civicrm_member_roles/civicrm_member_roles.module', 'civicrm_member_roles', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a32313a22436976694d656d62657220526f6c65732053796e63223b733a31313a226465736372697074696f6e223b733a3131313a2253796e6368726f6e697a65204369766943524d20436f6e74616374732077697468204d656d626572736869702053746174757320746f2061207370656369666965642044727570616c20526f6c6520626f7468206175746f6d61746963616c6c7920616e64206d616e75616c6c792e223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a224369766943524d223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a226369766963726d223b7d733a393a22636f6e666967757265223b733a34313a2261646d696e2f636f6e6669672f6369766963726d2f6369766963726d5f6d656d6265725f726f6c6573223b733a353a2266696c6573223b613a323a7b693a303b733a32373a226369766963726d5f6d656d6265725f726f6c65732e6d6f64756c65223b693a313b733a32383a226369766963726d5f6d656d6265725f726f6c65732e696e7374616c6c223b7d733a353a226d74696d65223b693a313437353634343230383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/civicrm/drupal/modules/civicrm_og_sync/civicrm_og_sync.module', 'civicrm_og_sync', 'module', '', 0, 0, -1, 0, 0x613a31313a7b733a343a226e616d65223b733a31353a224369766943524d204f472053796e63223b733a31313a226465736372697074696f6e223b733a3135343a2253796e6368726f6e697a65204f7267616e69632047726f75707320616e64204369766943524d2047726f75707320616e642041434c27732e204d6f726520696e666f726d6174696f6e2061743a20687474703a2f2f77696b692e6369766963726d2e6f72672f636f6e666c75656e63652f646973706c61792f43524d444f432f4369766943524d2b76732e2b4f7267616e69632b47726f757073223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a224369766943524d223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a373a226369766963726d223b693a313b733a323a226f67223b7d733a353a2266696c6573223b613a313a7b693a303b733a32323a226369766963726d5f6f675f73796e632e6d6f64756c65223b7d733a353a226d74696d65223b693a313437353634343230383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/civicrm/drupal/modules/civicrm_rules/civicrm_rules.module', 'civicrm_rules', 'module', '', 0, 0, -1, 0, 0x613a31313a7b733a343a226e616d65223b733a32353a224369766943524d2052756c657320496e746567726174696f6e223b733a31313a226465736372697074696f6e223b733a3132343a22496e74656772617465204369766943524d20616e642044727570616c2052756c6573204d6f64756c652e204578706f736520436f6e746163742c20436f6e747269627574696f6e20616e64206f74686572204f626a6563747320616c6f6e67207769746820466f726d202f2050616765204f7065726174696f6e732e223b733a373a2276657273696f6e223b733a363a22342e362e3232223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a224369766943524d223b733a373a2270726f6a656374223b733a373a226369766963726d223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a373a226369766963726d223b693a313b733a353a2272756c6573223b7d733a353a226d74696d65223b693a313437353634343230383b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/bulk_export/bulk_export.module', 'bulk_export', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31313a2242756c6b204578706f7274223b733a31313a226465736372697074696f6e223b733a36373a22506572666f726d732062756c6b206578706f7274696e67206f662064617461206f626a65637473206b6e6f776e2061626f7574206279204368616f7320746f6f6c732e223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/ctools.module', 'ctools', 'module', '', 1, 0, 7001, 0, 0x613a31323a7b733a343a226e616d65223b733a31313a224368616f7320746f6f6c73223b733a31313a226465736372697074696f6e223b733a34363a2241206c696272617279206f662068656c7066756c20746f6f6c73206279204d65726c696e206f66204368616f732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a353a2266696c6573223b613a353a7b693a303b733a32303a22696e636c756465732f636f6e746578742e696e63223b693a313b733a32323a22696e636c756465732f6373732d63616368652e696e63223b693a323b733a32323a22696e636c756465732f6d6174682d657870722e696e63223b693a333b733a32313a22696e636c756465732f7374796c697a65722e696e63223b693a343b733a32303a2274657374732f6373735f63616368652e74657374223b7d733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/ctools_access_ruleset/ctools_access_ruleset.module', 'ctools_access_ruleset', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31353a22437573746f6d2072756c6573657473223b733a31313a226465736372697074696f6e223b733a38313a2243726561746520637573746f6d2c206578706f727461626c652c207265757361626c65206163636573732072756c657365747320666f72206170706c69636174696f6e73206c696b652050616e656c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/ctools_ajax_sample/ctools_ajax_sample.module', 'ctools_ajax_sample', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a33333a224368616f7320546f6f6c73202843546f6f6c732920414a4158204578616d706c65223b733a31313a226465736372697074696f6e223b733a34313a2253686f777320686f7720746f207573652074686520706f776572206f66204368616f7320414a41582e223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a343a22636f7265223b733a333a22372e78223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/ctools_custom_content/ctools_custom_content.module', 'ctools_custom_content', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a32303a22437573746f6d20636f6e74656e742070616e6573223b733a31313a226465736372697074696f6e223b733a37393a2243726561746520637573746f6d2c206578706f727461626c652c207265757361626c6520636f6e74656e742070616e657320666f72206170706c69636174696f6e73206c696b652050616e656c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/ctools_plugin_example/ctools_plugin_example.module', 'ctools_plugin_example', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a33353a224368616f7320546f6f6c73202843546f6f6c732920506c7567696e204578616d706c65223b733a31313a226465736372697074696f6e223b733a37353a2253686f777320686f7720616e2065787465726e616c206d6f64756c652063616e2070726f766964652063746f6f6c7320706c7567696e732028666f722050616e656c732c206574632e292e223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a31323a22646570656e64656e63696573223b613a343a7b693a303b733a363a2263746f6f6c73223b693a313b733a363a2270616e656c73223b693a323b733a31323a22706167655f6d616e61676572223b693a333b733a31333a22616476616e6365645f68656c70223b7d733a343a22636f7265223b733a333a22372e78223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/page_manager/page_manager.module', 'page_manager', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31323a2250616765206d616e61676572223b733a31313a226465736372697074696f6e223b733a35343a2250726f7669646573206120554920616e642041504920746f206d616e6167652070616765732077697468696e2074686520736974652e223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/stylizer/stylizer.module', 'stylizer', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a383a225374796c697a6572223b733a31313a226465736372697074696f6e223b733a35333a2243726561746520637573746f6d207374796c657320666f72206170706c69636174696f6e7320737563682061732050616e656c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a363a2263746f6f6c73223b693a313b733a353a22636f6c6f72223b7d733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/term_depth/term_depth.module', 'term_depth', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31373a225465726d20446570746820616363657373223b733a31313a226465736372697074696f6e223b733a34383a22436f6e74726f6c732061636365737320746f20636f6e746578742062617365642075706f6e207465726d206465707468223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/tests/ctools_export_test/ctools_export_test.module', 'ctools_export_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31383a2243546f6f6c73206578706f72742074657374223b733a31313a226465736372697074696f6e223b733a32353a2243546f6f6c73206578706f72742074657374206d6f64756c65223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a363a2268696464656e223b623a313b733a353a2266696c6573223b613a313a7b693a303b733a31383a2263746f6f6c735f6578706f72742e74657374223b7d733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/tests/ctools_plugin_test.module', 'ctools_plugin_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a224368616f7320746f6f6c7320706c7567696e732074657374223b733a31313a226465736372697074696f6e223b733a34323a2250726f766964657320686f6f6b7320666f722074657374696e672063746f6f6c7320706c7567696e732e223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a353a2266696c6573223b613a363a7b693a303b733a31393a2263746f6f6c732e706c7567696e732e74657374223b693a313b733a31373a226f626a6563745f63616368652e74657374223b693a323b733a383a226373732e74657374223b693a333b733a31323a22636f6e746578742e74657374223b693a343b733a32303a226d6174685f65787072657373696f6e2e74657374223b693a353b733a32363a226d6174685f65787072657373696f6e5f737461636b2e74657374223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/ctools/views_content/views_content.module', 'views_content', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31393a22566965777320636f6e74656e742070616e6573223b733a31313a226465736372697074696f6e223b733a3130343a22416c6c6f777320566965777320636f6e74656e7420746f206265207573656420696e2050616e656c732c2044617368626f61726420616e64206f74686572206d6f64756c657320776869636820757365207468652043546f6f6c7320436f6e74656e74204150492e223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a363a2263746f6f6c73223b693a313b733a353a227669657773223b7d733a343a22636f7265223b733a333a22372e78223b733a373a2276657273696f6e223b733a383a22372e782d312e3131223b733a353a2266696c6573223b613a333a7b693a303b733a36313a22706c7567696e732f76696577732f76696577735f636f6e74656e745f706c7567696e5f646973706c61795f63746f6f6c735f636f6e746578742e696e63223b693a313b733a35373a22706c7567696e732f76696577732f76696577735f636f6e74656e745f706c7567696e5f646973706c61795f70616e656c5f70616e652e696e63223b693a323b733a35393a22706c7567696e732f76696577732f76696577735f636f6e74656e745f706c7567696e5f7374796c655f63746f6f6c735f636f6e746578742e696e63223b7d733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231343736353831363534223b733a353a226d74696d65223b693a313437363538313635343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d);
INSERT INTO `system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('sites/all/modules/entity/entity.module', 'entity', 'module', '', 1, 0, 7003, 0, 0x613a31323a7b733a343a226e616d65223b733a31303a22456e7469747920415049223b733a31313a226465736372697074696f6e223b733a36393a22456e61626c6573206d6f64756c657320746f20776f726b207769746820616e7920656e74697479207479706520616e6420746f2070726f7669646520656e7469746965732e223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a32343a7b693a303b733a31393a22656e746974792e66656174757265732e696e63223b693a313b733a31353a22656e746974792e6931386e2e696e63223b693a323b733a31353a22656e746974792e696e666f2e696e63223b693a333b733a31363a22656e746974792e72756c65732e696e63223b693a343b733a31313a22656e746974792e74657374223b693a353b733a31393a22696e636c756465732f656e746974792e696e63223b693a363b733a33303a22696e636c756465732f656e746974792e636f6e74726f6c6c65722e696e63223b693a373b733a32323a22696e636c756465732f656e746974792e75692e696e63223b693a383b733a32373a22696e636c756465732f656e746974792e777261707065722e696e63223b693a393b733a32323a2276696577732f656e746974792e76696577732e696e63223b693a31303b733a35323a2276696577732f68616e646c6572732f656e746974795f76696577735f6669656c645f68616e646c65725f68656c7065722e696e63223b693a31313b733a35313a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f617265615f656e746974792e696e63223b693a31323b733a35333a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f626f6f6c65616e2e696e63223b693a31333b733a35303a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f646174652e696e63223b693a31343b733a35343a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f6475726174696f6e2e696e63223b693a31353b733a35323a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f656e746974792e696e63223b693a31363b733a35313a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f6669656c642e696e63223b693a31373b733a35333a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f6e756d657269632e696e63223b693a31383b733a35333a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f6f7074696f6e732e696e63223b693a31393b733a35303a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f746578742e696e63223b693a32303b733a34393a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f6669656c645f7572692e696e63223b693a32313b733a36323a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f72656c6174696f6e736869705f62795f62756e646c652e696e63223b693a32323b733a35323a2276696577732f68616e646c6572732f656e746974795f76696577735f68616e646c65725f72656c6174696f6e736869702e696e63223b693a32333b733a35333a2276696577732f706c7567696e732f656e746974795f76696577735f706c7567696e5f726f775f656e746974795f766965772e696e63223b7d733a373a2276657273696f6e223b733a373a22372e782d312e38223b733a373a2270726f6a656374223b733a363a22656e74697479223b733a393a22646174657374616d70223b733a31303a2231343734353436353033223b733a353a226d74696d65223b693a313437343534363530333b733a31323a22646570656e64656e63696573223b613a303a7b7d733a373a227061636b616765223b733a353a224f74686572223b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/entity/entity_token.module', 'entity_token', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a31333a22456e7469747920746f6b656e73223b733a31313a226465736372697074696f6e223b733a39393a2250726f766964657320746f6b656e207265706c6163656d656e747320666f7220616c6c2070726f7065727469657320746861742068617665206e6f20746f6b656e7320616e6420617265206b6e6f776e20746f2074686520656e74697479204150492e223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a32333a22656e746974795f746f6b656e2e746f6b656e732e696e63223b693a313b733a31393a22656e746974795f746f6b656e2e6d6f64756c65223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a22656e74697479223b7d733a373a2276657273696f6e223b733a373a22372e782d312e38223b733a373a2270726f6a656374223b733a363a22656e74697479223b733a393a22646174657374616d70223b733a31303a2231343734353436353033223b733a353a226d74696d65223b693a313437343534363530333b733a373a227061636b616765223b733a353a224f74686572223b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/entity/tests/entity_feature.module', 'entity_feature', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a22456e746974792066656174757265206d6f64756c65223b733a31313a226465736372697074696f6e223b733a33313a2250726f766964657320736f6d6520656e74697469657320696e20636f64652e223b733a373a2276657273696f6e223b733a373a22372e782d312e38223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a32313a22656e746974795f666561747572652e6d6f64756c65223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31313a22656e746974795f74657374223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a22656e74697479223b733a393a22646174657374616d70223b733a31303a2231343734353436353033223b733a353a226d74696d65223b693a313437343534363530333b733a373a227061636b616765223b733a353a224f74686572223b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/entity/tests/entity_test.module', 'entity_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32333a22456e7469747920435255442074657374206d6f64756c65223b733a31313a226465736372697074696f6e223b733a34363a2250726f766964657320656e746974792074797065732062617365642075706f6e207468652043525544204150492e223b733a373a2276657273696f6e223b733a373a22372e782d312e38223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31383a22656e746974795f746573742e6d6f64756c65223b693a313b733a31393a22656e746974795f746573742e696e7374616c6c223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a22656e74697479223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a22656e74697479223b733a393a22646174657374616d70223b733a31303a2231343734353436353033223b733a353a226d74696d65223b693a313437343534363530333b733a373a227061636b616765223b733a353a224f74686572223b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/entity/tests/entity_test_i18n.module', 'entity_test_i18n', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32383a22456e746974792d746573742074797065207472616e736c6174696f6e223b733a31313a226465736372697074696f6e223b733a33373a22416c6c6f7773207472616e736c6174696e6720656e746974792d746573742074797065732e223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a31313a22656e746974795f74657374223b693a313b733a31313a226931386e5f737472696e67223b7d733a373a227061636b616765223b733a33353a224d756c74696c696e6775616c202d20496e7465726e6174696f6e616c697a6174696f6e223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a373a22372e782d312e38223b733a373a2270726f6a656374223b733a363a22656e74697479223b733a393a22646174657374616d70223b733a31303a2231343734353436353033223b733a353a226d74696d65223b693a313437343534363530333b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/entityreference/entityreference.module', 'entityreference', 'module', '', 1, 0, 7002, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a22456e74697479205265666572656e6365223b733a31313a226465736372697074696f6e223b733a35313a2250726f76696465732061206669656c6420746861742063616e207265666572656e6365206f7468657220656e7469746965732e223b733a373a227061636b616765223b733a363a224669656c6473223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a363a22656e74697479223b693a313b733a363a2263746f6f6c73223b7d733a31373a22746573745f646570656e64656e63696573223b613a323a7b693a303b733a353a226665656473223b693a313b733a353a227669657773223b7d733a353a2266696c6573223b613a31323a7b693a303b733a32373a22656e746974797265666572656e63652e6d6967726174652e696e63223b693a313b733a33303a22706c7567696e732f73656c656374696f6e2f61627374726163742e696e63223b693a323b733a32373a22706c7567696e732f73656c656374696f6e2f76696577732e696e63223b693a333b733a32393a22706c7567696e732f6265686176696f722f61627374726163742e696e63223b693a343b733a34303a2276696577732f656e746974797265666572656e63655f706c7567696e5f646973706c61792e696e63223b693a353b733a33383a2276696577732f656e746974797265666572656e63655f706c7567696e5f7374796c652e696e63223b693a363b733a34333a2276696577732f656e746974797265666572656e63655f706c7567696e5f726f775f6669656c64732e696e63223b693a373b733a33353a2274657374732f656e746974797265666572656e63652e68616e646c6572732e74657374223b693a383b733a33353a2274657374732f656e746974797265666572656e63652e7461786f6e6f6d792e74657374223b693a393b733a33323a2274657374732f656e746974797265666572656e63652e61646d696e2e74657374223b693a31303b733a33323a2274657374732f656e746974797265666572656e63652e66656564732e74657374223b693a31313b733a34353a2274657374732f656e746974797265666572656e63652e656e746974795f7472616e736c6174696f6e2e74657374223b7d733a373a2276657273696f6e223b733a373a22372e782d312e32223b733a373a2270726f6a656374223b733a31353a22656e746974797265666572656e6365223b733a393a22646174657374616d70223b733a31303a2231343734333036373430223b733a353a226d74696d65223b693a313437343330363734303b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/entityreference/examples/entityreference_behavior_example/entityreference_behavior_example.module', 'entityreference_behavior_example', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a33333a22456e74697479205265666572656e6365204265686176696f72204578616d706c65223b733a31313a226465736372697074696f6e223b733a37313a2250726f766964657320736f6d65206578616d706c6520636f646520666f7220696d706c656d656e74696e6720456e74697479205265666572656e6365206265686176696f72732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a363a224669656c6473223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31353a22656e746974797265666572656e6365223b7d733a373a2276657273696f6e223b733a373a22372e782d312e32223b733a373a2270726f6a656374223b733a31353a22656e746974797265666572656e6365223b733a393a22646174657374616d70223b733a31303a2231343734333036373430223b733a353a226d74696d65223b693a313437343330363734303b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/entityreference/tests/modules/entityreference_feeds_test/entityreference_feeds_test.module', 'entityreference_feeds_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a34313a22456e746974797265666572656e6365202d20466565647320696e746567726174696f6e207465737473223b733a31313a226465736372697074696f6e223b733a36353a22537570706f7274206d6f64756c6520666f722074686520456e746974797265666572656e6365202d20466565647320696e746567726174696f6e2074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a333a7b693a303b733a353a226665656473223b693a313b733a383a2266656564735f7569223b693a323b733a31353a22656e746974797265666572656e6365223b7d733a373a2276657273696f6e223b733a373a22372e782d312e32223b733a373a2270726f6a656374223b733a31353a22656e746974797265666572656e6365223b733a393a22646174657374616d70223b733a31303a2231343734333036373430223b733a353a226d74696d65223b693a313437343330363734303b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/module_filter/module_filter.module', 'module_filter', 'module', '', 1, 0, 7201, 0, 0x613a31333a7b733a343a226e616d65223b733a31333a224d6f64756c652066696c746572223b733a31313a226465736372697074696f6e223b733a32343a2246696c74657220746865206d6f64756c6573206c6973742e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31343a2241646d696e697374726174696f6e223b733a353a2266696c6573223b613a393a7b693a303b733a32313a226d6f64756c655f66696c7465722e696e7374616c6c223b693a313b733a31363a226d6f64756c655f66696c7465722e6a73223b693a323b733a32303a226d6f64756c655f66696c7465722e6d6f64756c65223b693a333b733a32333a226d6f64756c655f66696c7465722e61646d696e2e696e63223b693a343b733a32333a226d6f64756c655f66696c7465722e7468656d652e696e63223b693a353b733a32313a226373732f6d6f64756c655f66696c7465722e637373223b693a363b733a32353a226373732f6d6f64756c655f66696c7465725f7461622e637373223b693a373b733a31393a226a732f6d6f64756c655f66696c7465722e6a73223b693a383b733a32333a226a732f6d6f64756c655f66696c7465725f7461622e6a73223b7d733a393a22636f6e666967757265223b733a34303a2261646d696e2f636f6e6669672f757365722d696e746572666163652f6d6f64756c6566696c746572223b733a373a2276657273696f6e223b733a373a22372e782d322e30223b733a373a2270726f6a656374223b733a31333a226d6f64756c655f66696c746572223b733a393a22646174657374616d70223b733a31303a2231343234363331313839223b733a353a226d74696d65223b693a313432343633313138393b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/og/og.module', 'og', 'module', '', 1, 0, 7205, 0, 0x613a31323a7b733a343a226e616d65223b733a31343a224f7267616e69632067726f757073223b733a31313a226465736372697074696f6e223b733a34353a2241504920746f20616c6c6f77206173736f63696174696e6720636f6e74656e7420776974682067726f7570732e223b733a373a227061636b616765223b733a31343a224f7267616e69632067726f757073223b733a31323a22646570656e64656e63696573223b613a353a7b693a303b733a373a226f7074696f6e73223b693a313b733a343a226c697374223b693a323b733a343a2274657874223b693a333b733a363a22656e74697479223b693a343b733a31353a22656e746974797265666572656e6365223b7d733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a33313a7b693a303b733a31313a226f672e696e666f2e696e63223b693a313b733a32313a22696e636c756465732f6f672e61646d696e2e696e63223b693a323b733a32353a22696e636c756465732f6f672e657863657074696f6e2e696e63223b693a333b733a32363a22696e636c756465732f6f672e6d656d626572736869702e696e63223b693a343b733a33313a22696e636c756465732f6f672e6d656d626572736869705f747970652e696e63223b693a353b733a32373a22696e636c756465732f76696577732f6f672e76696577732e696e63223b693a363b733a373a226f672e74657374223b693a373b733a36313a22696e636c756465732f76696577732f68616e646c6572732f6f675f706c7567696e5f617267756d656e745f76616c69646174655f67726f75702e696e63223b693a383b733a36363a22696e636c756465732f76696577732f68616e646c6572732f6f675f706c7567696e5f617267756d656e745f64656661756c745f757365725f67726f7570732e696e63223b693a393b733a36333a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f6669656c645f67726f75705f6d656d6265725f636f756e742e696e63223b693a31303b733a36353a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f6669656c645f67726f75705f61756469656e63655f73746174652e696e63223b693a31313b733a35393a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f6669656c645f70726572656e6465725f6c6973742e696e63223b693a31323b733a35353a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f6669656c645f757365725f726f6c65732e696e63223b693a31333b733a36323a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f6669656c645f67726f75705f7065726d697373696f6e732e696e63223b693a31343b733a36383a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f6669656c645f6f675f6d656d626572736869705f6c696e6b5f656469742e696e63223b693a31353b733a37303a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f6669656c645f6f675f6d656d626572736869705f6c696e6b5f64656c6574652e696e63223b693a31363b733a36363a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f66696c7465725f67726f75705f61756469656e63655f73746174652e696e63223b693a31373b733a35363a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f66696c7465725f757365725f726f6c65732e696e63223b693a31383b733a35313a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f72656c6174696f6e736869702e696e63223b693a31393b733a36383a22696e636c756465732f76696577732f68616e646c6572732f6f675f68616e646c65725f72656c6174696f6e736869705f6d656d626572736869705f726f6c65732e696e63223b693a32303b733a35353a22696e636c756465732f6d6967726174652f706c7567696e732f64657374696e6174696f6e732f6f675f6d656d626572736869702e696e63223b693a32313b733a33393a22696e636c756465732f6d6967726174652f373030302f6f675f6164645f6669656c64732e696e63223b693a32323b733a33363a22696e636c756465732f6d6967726174652f373030302f6f675f636f6e74656e742e696e63223b693a32333b733a33343a22696e636c756465732f6d6967726174652f373030302f6f675f67726f75702e696e63223b693a32343b733a33333a22696e636c756465732f6d6967726174652f373030302f6f675f757365722e696e63223b693a32353b733a34373a22696e636c756465732f6d6967726174652f373030302f6f675f6f6775725f726f6c65732e6d6967726174652e696e63223b693a32363b733a34313a22696e636c756465732f6d6967726174652f373030302f6f675f6f6775722e6d6967726174652e696e63223b693a32373b733a33313a22696e636c756465732f6d6967726174652f6f672e6d6967726174652e696e63223b693a32383b733a35303a22696e636c756465732f6d6967726174652f373230302f6f675f6f675f6d656d626572736869702e6d6967726174652e696e63223b693a32393b733a34323a22696e636c756465732f6d6967726174652f373230302f6f675f726f6c65732e6d6967726174652e696e63223b693a33303b733a34373a22696e636c756465732f6d6967726174652f373230302f6f675f757365725f726f6c65732e6d6967726174652e696e63223b7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a323a226f67223b733a393a22646174657374616d70223b733a31303a2231343631313530323734223b733a353a226d74696d65223b693a313436313135303237343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/og/og_access/og_access.module', 'og_access', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a32393a224f7267616e69632067726f7570732061636365737320636f6e74726f6c223b733a31313a226465736372697074696f6e223b733a37303a22456e61626c652061636365737320636f6e74726f6c20666f72207072697661746520616e64207075626c69632067726f75707320616e642067726f757020636f6e74656e742e223b733a373a227061636b616765223b733a31343a224f7267616e69632067726f757073223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a323a226f67223b7d733a343a22636f7265223b733a333a22372e78223b733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a353a2266696c6573223b613a333a7b693a303b733a31363a226f675f6163636573732e6d6f64756c65223b693a313b733a31373a226f675f6163636573732e696e7374616c6c223b693a323b733a31343a226f675f6163636573732e74657374223b7d733a373a2270726f6a656374223b733a323a226f67223b733a393a22646174657374616d70223b733a31303a2231343631313530323734223b733a353a226d74696d65223b693a313436313135303237343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/og/og_context/og_context.module', 'og_context', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a32323a224f7267616e69632067726f75707320636f6e74657874223b733a31313a226465736372697074696f6e223b733a33313a2247657420612067726f75702066726f6d20612076696577656420706167652e223b733a373a227061636b616765223b733a31343a224f7267616e69632067726f757073223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a323a226f67223b7d733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a353a7b693a303b733a31373a226f675f636f6e746578742e6d6f64756c65223b693a313b733a31383a226f675f636f6e746578742e696e7374616c6c223b693a323b733a37363a22696e636c756465732f76696577732f68616e646c6572732f6f675f636f6e746578745f706c7567696e5f617267756d656e745f64656661756c745f67726f75705f636f6e746578742e696e63223b693a333b733a36303a22696e636c756465732f76696577732f68616e646c6572732f6f675f636f6e746578745f706c7567696e5f6163636573735f6f675f7065726d2e696e63223b693a343b733a31353a226f675f636f6e746578742e74657374223b7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a323a226f67223b733a393a22646174657374616d70223b733a31303a2231343631313530323734223b733a353a226d74696d65223b693a313436313135303237343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/og/og_example/og_example.module', 'og_example', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a224f47206578616d706c65223b733a31313a226465736372697074696f6e223b733a38373a224578616d706c65206d6f64756c6520746f2073686f77204f7267616e69632067726f75707320636f6e66696775726174696f6e20746861742063616e2062652075736564206173206275696c64696e6720626c6f636b2e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a383a224665617475726573223b733a31323a22646570656e64656e63696573223b613a31313a7b693a303b733a363a2263746f6f6c73223b693a313b733a32373a22656e746974797265666572656e63655f707265706f70756c617465223b693a323b733a383a226665617475726573223b693a333b733a343a226c697374223b693a343b733a31343a226d6573736167655f6e6f74696679223b693a353b733a323a226f67223b693a363b733a353a226f675f7569223b693a373b733a31323a22706167655f6d616e61676572223b693a383b733a363a2270616e656c73223b693a393b733a353a2272756c6573223b693a31303b733a31333a2276696577735f636f6e74656e74223b7d733a383a226665617475726573223b613a383a7b733a363a2263746f6f6c73223b613a313a7b693a303b733a32383a22706167655f6d616e616765723a70616765735f64656661756c743a31223b7d733a31323a2266656174757265735f617069223b613a313a7b693a303b733a353a226170693a32223b7d733a31303a226669656c645f62617365223b613a343a7b693a303b733a343a22626f6479223b693a313b733a32303a226669656c645f6e6f64655f7265666572656e6365223b693a323b733a31313a2267726f75705f67726f7570223b693a333b733a31323a226f675f67726f75705f726566223b7d733a31343a226669656c645f696e7374616e6365223b613a353a7b693a303b733a34333a226d6573736167652d6f675f6e65775f636f6e74656e742d6669656c645f6e6f64655f7265666572656e6365223b693a313b733a31353a226e6f64652d67726f75702d626f6479223b693a323b733a32323a226e6f64652d67726f75702d67726f75705f67726f7570223b693a333b733a31343a226e6f64652d706f73742d626f6479223b693a343b733a32323a226e6f64652d706f73742d6f675f67726f75705f726566223b7d733a31323a226d6573736167655f74797065223b613a313a7b693a303b733a31343a226f675f6e65775f636f6e74656e74223b7d733a343a226e6f6465223b613a323a7b693a303b733a353a2267726f7570223b693a313b733a343a22706f7374223b7d733a32313a22706167655f6d616e616765725f68616e646c657273223b613a313a7b693a303b733a32333a226e6f64655f766965775f70616e656c5f636f6e74657874223b7d733a31323a2272756c65735f636f6e666967223b613a313a7b693a303b733a32383a2272756c65735f6f675f6e65775f636f6e74656e745f6d657373616765223b7d7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a323a226f67223b733a393a22646174657374616d70223b733a31303a2231343631313530323734223b733a353a226d74696d65223b693a313436313135303237343b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/og/og_field_access/og_field_access.module', 'og_field_access', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a32373a224f7267616e69632067726f757073206669656c6420616363657373223b733a31313a226465736372697074696f6e223b733a33363a2250726f76696465206669656c6420616363657373206261736564206f6e2067726f75702e223b733a373a227061636b616765223b733a31343a224f7267616e69632067726f757073223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a323a226f67223b7d733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a32323a226f675f6669656c645f6163636573732e6d6f64756c65223b693a313b733a32303a226f675f6669656c645f6163636573732e74657374223b7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a323a226f67223b733a393a22646174657374616d70223b733a31303a2231343631313530323734223b733a353a226d74696d65223b693a313436313135303237343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/og/og_register/og_register.module', 'og_register', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a32333a224f7267616e69632067726f757073207265676973746572223b733a31313a226465736372697074696f6e223b733a35373a22416c6c6f77207375627363726962696e6720746f2067726f75707320647572696e6720746865207573657220726567697374726174696f6e2e223b733a373a227061636b616765223b733a31343a224f7267616e69632067726f757073223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a323a226f67223b7d733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31383a226f675f72656769737465722e6d6f64756c65223b693a313b733a31393a226f675f72656769737465722e696e7374616c6c223b7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a323a226f67223b733a393a22646174657374616d70223b733a31303a2231343631313530323734223b733a353a226d74696d65223b693a313436313135303237343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/og/og_ui/og_ui.module', 'og_ui', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a224f7267616e69632067726f757073205549223b733a31313a226465736372697074696f6e223b733a31383a224f7267616e69632067726f7570732055492e223b733a373a227061636b616765223b733a31343a224f7267616e69632067726f757073223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a323a226f67223b693a313b733a32313a2276696577735f62756c6b5f6f7065726174696f6e73223b7d733a343a22636f7265223b733a333a22372e78223b733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a353a2266696c6573223b613a353a7b693a303b733a31303a226f675f75692e74657374223b693a313b733a36393a22696e636c756465732f76696577732f68616e646c6572732f6f675f75695f68616e646c65725f617265615f6f675f6d656d626572736869705f6f766572766965772e696e63223b693a323b733a33353a22696e636c756465732f6d6967726174652f373030302f6164645f6669656c642e696e63223b693a333b733a34303a22696e636c756465732f6d6967726174652f373030302f706f70756c6174655f6669656c642e696e63223b693a343b733a33353a22696e636c756465732f6d6967726174652f373030302f7365745f726f6c65732e696e63223b7d733a393a22636f6e666967757265223b733a31383a2261646d696e2f636f6e6669672f67726f7570223b733a373a2270726f6a656374223b733a323a226f67223b733a393a22646174657374616d70223b733a31303a2231343631313530323734223b733a353a226d74696d65223b693a313436313135303237343b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/og/tests/og_test.module', 'og_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a224f472074657374206d6f64756c65223b733a31313a226465736372697074696f6e223b733a33353a2246756e6374696f6e616c69747920746f20617373697374204f472074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a323a226f67223b7d733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a323a226f67223b733a393a22646174657374616d70223b733a31303a2231343631313530323734223b733a353a226d74696d65223b693a313436313135303237343b733a373a227061636b616765223b733a353a224f74686572223b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/rules/rules.module', 'rules', 'module', '', 1, 1, 7214, 20, 0x613a31323a7b733a343a226e616d65223b733a353a2252756c6573223b733a31313a226465736372697074696f6e223b733a35313a225265616374206f6e206576656e747320616e6420636f6e646974696f6e616c6c79206576616c7561746520616374696f6e732e223b733a373a227061636b616765223b733a353a2252756c6573223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a31373a7b693a303b733a31383a2272756c65732e66656174757265732e696e63223b693a313b733a31363a2274657374732f72756c65732e74657374223b693a323b733a31383a22696e636c756465732f66616365732e696e63223b693a333b733a32333a22696e636c756465732f72756c65732e636f72652e696e63223b693a343b733a32343a22696e636c756465732f72756c65732e6576656e742e696e63223b693a353b733a32383a22696e636c756465732f72756c65732e70726f636573736f722e696e63223b693a363b733a32363a22696e636c756465732f72756c65732e706c7567696e732e696e63223b693a373b733a32343a22696e636c756465732f72756c65732e73746174652e696e63223b693a383b733a32393a22696e636c756465732f72756c65732e646973706174636865722e696e63223b693a393b733a32313a226d6f64756c65732f6e6f64652e6576616c2e696e63223b693a31303b733a32303a226d6f64756c65732f7068702e6576616c2e696e63223b693a31313b733a32373a226d6f64756c65732f72756c65735f636f72652e6576616c2e696e63223b693a31323b733a32333a226d6f64756c65732f73797374656d2e6576616c2e696e63223b693a31333b733a32303a2275692f75692e636f6e74726f6c6c65722e696e63223b693a31343b733a31343a2275692f75692e636f72652e696e63223b693a31353b733a31343a2275692f75692e646174612e696e63223b693a31363b733a31373a2275692f75692e706c7567696e732e696e63223b7d733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a31323a22656e746974795f746f6b656e223b693a313b733a363a22656e74697479223b7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a353a2272756c6573223b733a393a22646174657374616d70223b733a31303a2231343236353237323130223b733a353a226d74696d65223b693a313432363532373231303b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/rules/rules_admin/rules_admin.module', 'rules_admin', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a383a2252756c6573205549223b733a31313a226465736372697074696f6e223b733a34343a2241646d696e69737472617469766520696e7465726661636520666f72206d616e6167696e672072756c65732e223b733a373a227061636b616765223b733a353a2252756c6573223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31383a2272756c65735f61646d696e2e6d6f64756c65223b693a313b733a31353a2272756c65735f61646d696e2e696e63223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a2272756c6573223b7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a353a2272756c6573223b733a393a22646174657374616d70223b733a31303a2231343236353237323130223b733a353a226d74696d65223b693a313432363532373231303b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/rules/rules_i18n/rules_i18n.module', 'rules_i18n', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31373a2252756c6573207472616e736c6174696f6e223b733a31313a226465736372697074696f6e223b733a32353a22416c6c6f7773207472616e736c6174696e672072756c65732e223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a353a2272756c6573223b693a313b733a31313a226931386e5f737472696e67223b7d733a373a227061636b616765223b733a33353a224d756c74696c696e6775616c202d20496e7465726e6174696f6e616c697a6174696f6e223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a333a7b693a303b733a31393a2272756c65735f6931386e2e6931386e2e696e63223b693a313b733a32303a2272756c65735f6931386e2e72756c65732e696e63223b693a323b733a31353a2272756c65735f6931386e2e74657374223b7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a353a2272756c6573223b733a393a22646174657374616d70223b733a31303a2231343236353237323130223b733a353a226d74696d65223b693a313432363532373231303b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/rules/rules_scheduler/rules_scheduler.module', 'rules_scheduler', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31353a2252756c6573205363686564756c6572223b733a31313a226465736372697074696f6e223b733a35373a225363686564756c652074686520657865637574696f6e206f662052756c657320636f6d706f6e656e7473207573696e6720616374696f6e732e223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a2272756c6573223b7d733a373a227061636b616765223b733a353a2252756c6573223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a393a7b693a303b733a32353a2272756c65735f7363686564756c65722e61646d696e2e696e63223b693a313b733a32323a2272756c65735f7363686564756c65722e6d6f64756c65223b693a323b733a32333a2272756c65735f7363686564756c65722e696e7374616c6c223b693a333b733a32353a2272756c65735f7363686564756c65722e72756c65732e696e63223b693a343b733a32303a2272756c65735f7363686564756c65722e74657374223b693a353b733a33363a22696e636c756465732f72756c65735f7363686564756c65722e68616e646c65722e696e63223b693a363b733a34323a22696e636c756465732f72756c65735f7363686564756c65722e76696577735f64656661756c742e696e63223b693a373b733a33343a22696e636c756465732f72756c65735f7363686564756c65722e76696577732e696e63223b693a383b733a34313a22696e636c756465732f72756c65735f7363686564756c65725f76696577735f66696c7465722e696e63223b7d733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a353a2272756c6573223b733a393a22646174657374616d70223b733a31303a2231343236353237323130223b733a353a226d74696d65223b693a313432363532373231303b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/rules/rules_scheduler/tests/rules_scheduler_test.module', 'rules_scheduler_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a2252756c6573205363686564756c6572205465737473223b733a31313a226465736372697074696f6e223b733a34353a22537570706f7274206d6f64756c6520666f72207468652052756c6573205363686564756c65722074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a32343a2272756c65735f7363686564756c65725f746573742e696e63223b7d733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a353a2272756c6573223b733a393a22646174657374616d70223b733a31303a2231343236353237323130223b733a353a226d74696d65223b693a313432363532373231303b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/rules/tests/rules_test.module', 'rules_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a2252756c6573205465737473223b733a31313a226465736372697074696f6e223b733a33353a22537570706f7274206d6f64756c6520666f72207468652052756c65732074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a32303a2272756c65735f746573742e72756c65732e696e63223b693a313b733a32393a2272756c65735f746573742e72756c65735f64656661756c74732e696e63223b7d733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a353a2272756c6573223b733a393a22646174657374616d70223b733a31303a2231343236353237323130223b733a353a226d74696d65223b693a313432363532373231303b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/rules/tests/rules_test_invocation.module', 'rules_test_invocation', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a2252756c6573205465737420696e766f636174696f6e223b733a31313a226465736372697074696f6e223b733a34303a2248656c706572206d6f64756c6520746f20746573742052756c657320696e766f636174696f6e732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a373a22372e782d322e39223b733a373a2270726f6a656374223b733a353a2272756c6573223b733a393a22646174657374616d70223b733a31303a2231343236353237323130223b733a353a226d74696d65223b693a313432363532373231303b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('themes/bartik/bartik.info', 'bartik', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 1, 0, -1, 0, 0x613a31393a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a32303a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d),
('themes/garland/garland.info', 'garland', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 0, 0, -1, 0, 0x613a31393a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d),
('themes/seven/seven.info', 'seven', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 1, 0, -1, 0, 0x613a31393a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a383a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d),
('themes/stark/stark.info', 'stark', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 0, 0, -1, 0, 0x613a31383a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3531223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343735363934313734223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313437353639343137343b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a31313a22706167655f626f74746f6d223b7d7d);

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_index`
--

CREATE TABLE `taxonomy_index` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_term_data`
--

CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.';

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_term_hierarchy`
--

CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_vocabulary`
--

CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';

--
-- Dumping data for table `taxonomy_vocabulary`
--

INSERT INTO `taxonomy_vocabulary` (`vid`, `name`, `machine_name`, `description`, `hierarchy`, `module`, `weight`) VALUES
(1, 'Tags', 'tags', 'Use tags to group articles on similar topics into categories.', 0, 'taxonomy', 0);

-- --------------------------------------------------------

--
-- Table structure for table `url_alias`
--

CREATE TABLE `url_alias` (
  `pid` int(10) UNSIGNED NOT NULL COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `name`, `pass`, `mail`, `theme`, `signature`, `signature_format`, `created`, `access`, `login`, `status`, `timezone`, `language`, `picture`, `init`, `data`) VALUES
(0, '', '', '', '', '', NULL, 0, 0, 0, 0, NULL, '', 0, '', NULL),
(1, 'admin', '$S$DEt21/jELRQllQpNKau8FCtIsE8uY4psiP0C/NuNMw0u0QC6pVzX', 'admin@example.com', '', '', NULL, 1477110568, 1477125280, 1477125280, 1, 'Asia/Karachi', '', 0, 'admin@example.com', 0x623a303b);

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`uid`, `rid`) VALUES
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `variable`
--

CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';

--
-- Dumping data for table `variable`
--

INSERT INTO `variable` (`name`, `value`) VALUES
('admin_theme', 0x733a353a22736576656e223b),
('cache_class_cache_ctools_css', 0x733a31343a2243546f6f6c734373734361636865223b),
('civicrm_class_loader', 0x733a32383a222f2e2e2f43524d2f436f72652f436c6173734c6f616465722e706870223b),
('clean_url', 0x623a313b),
('comment_page', 0x693a303b),
('cron_key', 0x733a34333a224a357555394f68396b5773617645656e617247336c38384d4f45664a545f6769515538385a486c3257386b223b),
('cron_last', 0x693a313437373132313539383b),
('css_js_query_string', 0x733a363a226f6666756973223b),
('ctools_last_cron', 0x693a313437373132313539393b),
('date_default_timezone', 0x733a31323a22417369612f4b617261636869223b),
('drupal_private_key', 0x733a34333a224a4f58484e717a657348583750347961363355654b46684a4f575a57635a424c72686f4968795a34506d4d223b),
('entityreference:base-tables', 0x613a393a7b733a373a22636f6d6d656e74223b613a323a7b693a303b733a373a22636f6d6d656e74223b693a313b733a333a22636964223b7d733a343a226e6f6465223b613a323a7b693a303b733a343a226e6f6465223b693a313b733a333a226e6964223b7d733a31383a226f675f6d656d626572736869705f74797065223b613a323a7b693a303b733a31383a226f675f6d656d626572736869705f74797065223b693a313b733a323a226964223b7d733a31333a226f675f6d656d62657273686970223b613a323a7b693a303b733a31333a226f675f6d656d62657273686970223b693a313b733a323a226964223b7d733a343a2266696c65223b613a323a7b693a303b733a31323a2266696c655f6d616e61676564223b693a313b733a333a22666964223b7d733a31333a227461786f6e6f6d795f7465726d223b613a323a7b693a303b733a31383a227461786f6e6f6d795f7465726d5f64617461223b693a313b733a333a22746964223b7d733a31393a227461786f6e6f6d795f766f636162756c617279223b613a323a7b693a303b733a31393a227461786f6e6f6d795f766f636162756c617279223b693a313b733a333a22766964223b7d733a343a2275736572223b613a323a7b693a303b733a353a227573657273223b693a313b733a333a22756964223b7d733a31323a2272756c65735f636f6e666967223b613a323a7b693a303b733a31323a2272756c65735f636f6e666967223b693a313b733a323a226964223b7d7d),
('file_temporary_path', 0x733a343a222f746d70223b),
('filter_fallback_format', 0x733a31303a22706c61696e5f74657874223b),
('install_profile', 0x733a383a227374616e64617264223b),
('install_task', 0x733a343a22646f6e65223b),
('install_time', 0x693a313437373131303536383b),
('menu_expanded', 0x613a303a7b7d),
('menu_masks', 0x613a33383a7b693a303b693a3530313b693a313b693a3439333b693a323b693a3235313b693a333b693a3235303b693a343b693a3234373b693a353b693a3234363b693a363b693a3234353b693a373b693a3132353b693a383b693a3132343b693a393b693a3132333b693a31303b693a3132323b693a31313b693a3132313b693a31323b693a3131373b693a31333b693a3131323b693a31343b693a36333b693a31353b693a36323b693a31363b693a36313b693a31373b693a36303b693a31383b693a35393b693a31393b693a35383b693a32303b693a35363b693a32313b693a34343b693a32323b693a33313b693a32333b693a33303b693a32343b693a32393b693a32353b693a32383b693a32363b693a32343b693a32373b693a32313b693a32383b693a31353b693a32393b693a31343b693a33303b693a31333b693a33313b693a31313b693a33323b693a373b693a33333b693a363b693a33343b693a353b693a33353b693a333b693a33363b693a323b693a33373b693a313b7d),
('node_admin_theme', 0x733a313a2231223b),
('node_options_page', 0x613a313a7b693a303b733a363a22737461747573223b7d),
('node_submitted_page', 0x623a303b),
('path_alias_whitelist', 0x613a303a7b7d),
('site_default_country', 0x733a303a22223b),
('site_mail', 0x733a31373a2261646d696e406578616d706c652e636f6d223b),
('site_name', 0x733a31323a22536974652d496e7374616c6c223b),
('theme_default', 0x733a353a22736576656e223b),
('update_last_check', 0x693a313437373132313633363b),
('update_notify_emails', 0x613a313a7b693a303b733a31373a2261646d696e406578616d706c652e636f6d223b7d),
('user_admin_role', 0x733a313a2233223b),
('user_pictures', 0x733a313a2231223b),
('user_picture_dimensions', 0x733a393a22313032347831303234223b),
('user_picture_file_size', 0x733a333a22383030223b),
('user_picture_style', 0x733a393a227468756d626e61696c223b),
('user_register', 0x693a323b);

-- --------------------------------------------------------

--
-- Table structure for table `watchdog`
--

CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';

--
-- Dumping data for table `watchdog`
--

INSERT INTO `watchdog` (`wid`, `uid`, `type`, `message`, `variables`, `severity`, `link`, `location`, `referer`, `hostname`, `timestamp`) VALUES
(1, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a2264626c6f67223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110767),
(2, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a2264626c6f67223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110767),
(3, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a226669656c645f7569223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110769),
(4, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a226669656c645f7569223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110769),
(5, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2266696c65223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110769),
(6, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2266696c65223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110770),
(7, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a227461786f6e6f6d79223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110781),
(8, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a227461786f6e6f6d79223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110781),
(9, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2268656c70223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110784),
(10, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2268656c70223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110784),
(11, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a22696d616765223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110797),
(12, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a22696d616765223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110797),
(13, 0, 'access denied', 'node', 0x4e3b, 4, '', 'http://127.0.0.1:8001/civicrmTest/', '', '127.0.0.1', 1477110815),
(14, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a226d656e75223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110827),
(15, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a226d656e75223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110837),
(16, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a226e756d626572223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110842),
(17, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a226e756d626572223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110842),
(18, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226f7665726c6179223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110844),
(19, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226f7665726c6179223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110844),
(20, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2270617468223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110847),
(21, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2270617468223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110847),
(22, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a333a22726466223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110851),
(23, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a333a22726466223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110851),
(24, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22736561726368223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110864),
(25, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22736561726368223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110864),
(26, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a2273686f7274637574223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110876),
(27, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a2273686f7274637574223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110876),
(28, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a22746f6f6c626172223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110878),
(29, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a22746f6f6c626172223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110878),
(30, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a227374616e64617264223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110991),
(31, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a227374616e64617264223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477110991),
(32, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31353a225075626c69736820636f6d6d656e74223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111015),
(33, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31373a22556e7075626c69736820636f6d6d656e74223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111015),
(34, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31323a225361766520636f6d6d656e74223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(35, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31353a225075626c69736820636f6e74656e74223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(36, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31373a22556e7075626c69736820636f6e74656e74223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(37, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31393a224d616b6520636f6e74656e7420737469636b79223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(38, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a32313a224d616b6520636f6e74656e7420756e737469636b79223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(39, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a32393a2250726f6d6f746520636f6e74656e7420746f2066726f6e742070616765223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(40, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a33303a2252656d6f766520636f6e74656e742066726f6d2066726f6e742070616765223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(41, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31323a225361766520636f6e74656e74223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(42, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a33303a2242616e2049502061646472657373206f662063757272656e742075736572223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111016),
(43, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31383a22426c6f636b2063757272656e742075736572223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111017),
(44, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22757064617465223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111048),
(45, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22757064617465223b7d, 6, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111048),
(46, 1, 'user', 'Session opened for %name.', 0x613a313a7b733a353a22256e616d65223b733a353a2261646d696e223b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111050),
(47, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'http://localhost/usr/bin/drush?/usr/bin/drush', '', '127.0.0.1', 1477111068),
(48, 1, 'user', 'Session opened for %name.', 0x613a313a7b733a353a22256e616d65223b733a353a2261646d696e223b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/node?destination=node', 'http://127.0.0.1:8001/civicrmTest/', '127.0.0.1', 1477111161),
(49, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a31333a226d6f64756c655f66696c746572223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111176),
(50, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31333a226d6f64756c655f66696c746572223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111177),
(51, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a31303a2261646d696e5f6d656e75223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111179),
(52, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31303a2261646d696e5f6d656e75223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111179),
(53, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a2263746f6f6c73223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111181),
(54, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a2263746f6f6c73223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111181),
(55, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a31383a2261646d696e5f6d656e755f746f6f6c626172223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111182),
(56, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31383a2261646d696e5f6d656e755f746f6f6c626172223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111182),
(57, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22656e74697479223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111183),
(58, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22656e74697479223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111183),
(59, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a31353a22656e746974797265666572656e6365223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111185),
(60, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31353a22656e746974797265666572656e6365223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111185),
(61, 1, 'page not found', 'sites/all/modules/civicrm/install.php', 0x4e3b, 4, '', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install.php', '', '127.0.0.1', 1477111191),
(62, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a323a226f67223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111194),
(63, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a323a226f67223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111195),
(64, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a31323a22656e746974795f746f6b656e223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111197),
(65, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31323a22656e746974795f746f6b656e223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111197),
(66, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a2272756c6573223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111204),
(67, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a2272756c6573223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111204),
(68, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31373a2252656d6f76652066726f6d2067726f7570223b7d, 5, '', 'http://default/index.php', '', '127.0.0.1', 1477111212),
(69, 0, 'system', '%module module disabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a22746f6f6c626172223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111225),
(70, 0, 'system', '%module module disabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226f7665726c6179223b7d, 6, '', 'http://default/index.php', '', '127.0.0.1', 1477111226),
(71, 1, 'page not found', 'sites/all/modules/civicrm/install.php', 0x4e3b, 4, '', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install.php', '', '127.0.0.1', 1477111245),
(72, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226369766963726d223b7d, 6, '', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install/index.php', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install/index.php', '127.0.0.1', 1477111629),
(73, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226369766963726d223b7d, 6, '', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install/index.php', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install/index.php', '127.0.0.1', 1477111660),
(74, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a31323a226369766963726d7468656d65223b7d, 6, '', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install/index.php', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install/index.php', '127.0.0.1', 1477111663),
(75, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31323a226369766963726d7468656d65223b7d, 6, '', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install/index.php', 'http://127.0.0.1:8001/civicrmTest/sites/all/modules/civicrm/install/index.php', '127.0.0.1', 1477111663),
(76, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a33363a22556e646566696e656420696e6465783a207065726d697373696f6e5f6f70657261746f72223b733a393a222566756e6374696f6e223b733a34343a2243524d5f436f72655f42414f5f44617368626f6172643a3a696e697469616c697a65446173686c6574732829223b733a353a222566696c65223b733a38303a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f436f72652f42414f2f44617368626f6172642e706870223b733a353a22256c696e65223b693a3138333b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/dashboard?op=get_widgets_by_column&key=3a3cebae63a4dc779f60a957b38e58fe', 'http://127.0.0.1:8001/civicrmTest/civicrm/dashboard', '127.0.0.1', 1477111858),
(77, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31343a22537472696374207761726e696e67223b733a383a22216d657373616765223b733a3232363a2263616c6c5f757365725f66756e632829206578706563747320706172616d65746572203120746f20626520612076616c69642063616c6c6261636b2c206e6f6e2d737461746963206d6574686f642043524d5f5265706f72745f466f726d5f416374697669747953756d6d6172793a3a666f726d52756c6528292073686f756c64206e6f742062652063616c6c656420737461746963616c6c792c20617373756d696e672024746869732066726f6d20636f6d70617469626c6520636f6e746578742043524d5f5265706f72745f466f726d5f416374697669747953756d6d617279223b733a393a222566756e6374696f6e223b733a32363a2248544d4c5f517569636b466f726d2d3e76616c69646174652829223b733a353a222566696c65223b733a38313a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f7061636b616765732f48544d4c2f517569636b466f726d2e706870223b733a353a22256c696e65223b693a313539383b733a31343a2273657665726974795f6c6576656c223b693a373b7d, 7, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/report/activitySummary', 'http://127.0.0.1:8001/civicrmTest/civicrm/report/activitySummary?reset=1', '127.0.0.1', 1477112739),
(78, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/menujs/202/en_US/1/YLaAGn9K', 'http://127.0.0.1:8001/civicrmTest/civicrm/report/list?reset=1', '127.0.0.1', 1477113344),
(79, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/l10n-js/en_US?r=6rCRv', 'http://127.0.0.1:8001/civicrmTest/civicrm/admin/report/register', '127.0.0.1', 1477113886),
(80, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/menujs/202/en_US/1/YLaAGn9K', 'http://127.0.0.1:8001/civicrmTest/civicrm/admin/report/options/report_template?reset=1', '127.0.0.1', 1477114032),
(81, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/l10n-js/en_US?r=6rCRv', 'http://127.0.0.1:8001/civicrmTest/civicrm/report/list?reset=1', '127.0.0.1', 1477114499),
(82, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33393a22496e76616c696420617267756d656e7420737570706c69656420666f7220666f72656163682829223b733a393a222566756e6374696f6e223b733a34313a2243524d5f5265706f72745f466f726d2d3e616c746572437573746f6d44617461446973706c61792829223b733a353a222566696c65223b733a37333a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f5265706f72742f466f726d2e706870223b733a353a22256c696e65223b693a313934323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/report/contact/CustomReport', 'http://127.0.0.1:8001/civicrmTest/civicrm/report/contact/CustomReport?reset=1', '127.0.0.1', 1477114599),
(83, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/rest?entity=contact&action=getlist&json=%7B%22params%22%3A%7B%22contact_type%22%3A%22Individual%22%7D%2C%22extra%22%3A%5B%22email%22%5D%2C%22input%22%3A%22ir%22%2C%22page_num%22%3A1%7D&_=1477119795896', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477119808),
(84, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/event/add?action=add&reset=1&template_id=4&snippet=json', 'http://127.0.0.1:8001/civicrmTest/civicrm/event/add?reset=1&action=add', '127.0.0.1', 1477119891),
(85, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/event/add?action=add&reset=1&template_id=6&snippet=json', 'http://127.0.0.1:8001/civicrmTest/civicrm/event/add?reset=1&action=add', '127.0.0.1', 1477120237),
(86, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/rest?entity=contact&action=getlist&json=%7B%22params%22%3A%7B%22contact_type%22%3A%22Individual%22%7D%2C%22extra%22%3A%5B%22email%22%5D%2C%22input%22%3A%22iri%22%2C%22page_num%22%3A1%7D&_=1477120309712', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477120325),
(87, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477120332),
(88, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477120332),
(89, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477120342),
(90, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477120342),
(91, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&type=Participant&subType=null&subName=null&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&cgcount=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120344),
(92, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120344),
(93, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120345),
(94, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120367),
(95, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120368),
(96, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&type=Participant&subType=null&subName=null&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&cgcount=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120370),
(97, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120370),
(98, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120371),
(99, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120407),
(100, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120407),
(101, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&type=Participant&subType=null&subName=null&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&cgcount=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120409),
(102, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120409),
(103, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120410),
(104, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120445),
(105, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120445),
(106, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&type=Participant&subType=null&subName=null&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&cgcount=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120447),
(107, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120448),
(108, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120448),
(109, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120474),
(110, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120475),
(111, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&type=Participant&subType=null&subName=null&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&cgcount=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120477),
(112, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120477),
(113, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120477),
(114, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120492),
(115, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120493),
(116, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&type=Participant&subType=null&subName=null&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&cgcount=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120495),
(117, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120495),
(118, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_7839&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120496),
(119, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_3398&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120543),
(120, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_3398&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477120544),
(121, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/contribution?reset=1&force=1&cid=8&snippet=json', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view?reset=1&cid=8&selectedChild=participant', '127.0.0.1', 1477120564);
INSERT INTO `watchdog` (`wid`, `uid`, `type`, `message`, `variables`, `severity`, `link`, `location`, `referer`, `hostname`, `timestamp`) VALUES
(122, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_6968&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477121243),
(123, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_6968&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477121243),
(124, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477121265),
(125, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add?reset=1&action=add&context=standalone', '127.0.0.1', 1477121266),
(126, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&type=Participant&subType=null&subName=null&qfKey=26fe2dd82023ce89e34886814ef54d10_6968&cgcount=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477121268),
(127, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_6968&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477121268),
(128, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_6968&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477121269),
(129, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477121286),
(130, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477121286),
(131, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&type=Participant&subType=null&subName=null&qfKey=26fe2dd82023ce89e34886814ef54d10_6968&cgcount=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477121288),
(132, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a206576656e74223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639363b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_6968&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477121288),
(133, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32383a22556e646566696e6564207661726961626c653a20656c656d656e7473223b733a393a222566756e6374696f6e223b733a35313a2243524d5f4576656e745f466f726d5f526567697374726174696f6e5f52656769737465723a3a6275696c64416d6f756e742829223b733a353a222566696c65223b733a39343a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f4576656e742f466f726d2f526567697374726174696f6e2f52656769737465722e706870223b733a353a22256c696e65223b693a3639373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/participant?snippet=4&qfKey=26fe2dd82023ce89e34886814ef54d10_6968&eventId=8', 'http://127.0.0.1:8001/civicrmTest/civicrm/participant/add', '127.0.0.1', 1477121289),
(134, 0, 'cron', 'Attempting to re-run cron while it is already running.', 0x613a303a7b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/admin/tag?reset=1&action=add', 'http://127.0.0.1:8001/civicrmTest/civicrm/admin/tag?reset=1&action=add', '127.0.0.1', 1477121624),
(135, 0, 'cron', 'Attempting to re-run cron while it is already running.', 0x613a303a7b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/admin/appearance', 'http://127.0.0.1:8001/civicrmTest/civicrm/admin/tag?reset=1&action=add', '127.0.0.1', 1477121636),
(136, 0, 'cron', 'Attempting to re-run cron while it is already running.', 0x613a303a7b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/js/admin_menu/cache/089d809c49f01103973013a937ee8f4f', 'http://127.0.0.1:8001/civicrmTest/admin/appearance', '127.0.0.1', 1477121638),
(137, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/report/list?compid=99&reset=1', 'http://127.0.0.1:8001/civicrmTest/civicrm/admin/tag?reset=1&action=add', '127.0.0.1', 1477121638),
(138, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/menujs/202/en_US/1/YLaAGn9K', 'http://127.0.0.1:8001/civicrmTest/civicrm/report/list?compid=99&reset=1', '127.0.0.1', 1477121653),
(139, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/search/advanced', 'http://127.0.0.1:8001/civicrmTest/civicrm/admin/options/activity_type?reset=1', '127.0.0.1', 1477121801),
(140, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/menujs/202/en_US/1/EpHusJUV', 'http://127.0.0.1:8001/civicrmTest/civicrm/admin?reset=1', '127.0.0.1', 1477121865),
(141, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/rest?entity=contact&action=getlist&json=%7B%22params%22%3A%7B%22contact_type%22%3A%22Individual%22%7D%2C%22input%22%3A%22iris%22%2C%22page_num%22%3A1%7D&_=1477121879069', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477121891),
(142, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=8&id=1', '127.0.0.1', 1477121929),
(143, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=8&id=1', '127.0.0.1', 1477121929),
(144, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/activity?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=8&id=1', '127.0.0.1', 1477121929),
(145, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&id=1&cid=8&action=view&context=dashboard&selectedChild=case', '127.0.0.1', 1477122361),
(146, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&id=1&cid=8&action=view&context=dashboard&selectedChild=case', '127.0.0.1', 1477122362),
(147, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/activity?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&id=1&cid=8&action=view&context=dashboard&selectedChild=case', '127.0.0.1', 1477122362),
(148, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/activity?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&id=1&cid=8&action=view&context=dashboard&selectedChild=case', '127.0.0.1', 1477122362),
(149, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&id=1&cid=8&action=view&context=dashboard&selectedChild=case', '127.0.0.1', 1477122362),
(150, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=1&cid=8&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&id=1&cid=8&action=view&context=dashboard&selectedChild=case', '127.0.0.1', 1477122362),
(151, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/rest?entity=contact&action=getlist&json=%7B%22params%22%3A%7B%22contact_type%22%3A%22Individual%22%7D%2C%22input%22%3A%22ka%22%2C%22page_num%22%3A1%7D&_=1477122878728', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477122933),
(152, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=2&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=2', '127.0.0.1', 1477122973),
(153, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=2&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=2', '127.0.0.1', 1477122973),
(154, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=2&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=2', '127.0.0.1', 1477122974),
(155, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=3&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=3', '127.0.0.1', 1477123116),
(156, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=3&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=3', '127.0.0.1', 1477123116),
(157, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/activity?snippet=4&caseID=3&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=3', '127.0.0.1', 1477123116),
(158, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=3&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=3', '127.0.0.1', 1477123116),
(159, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/rest?entity=contact&action=getlist&json=%7B%22params%22%3A%7B%22contact_type%22%3A%22Individual%22%7D%2C%22input%22%3A%22kath%22%2C%22page_num%22%3A1%7D&_=1477123409241', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477123419),
(160, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=4&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=4', '127.0.0.1', 1477123442),
(161, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=4&cid=17&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=17&id=4', '127.0.0.1', 1477123442),
(162, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=5&cid=30&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=30&id=5', '127.0.0.1', 1477124981),
(163, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=5&cid=30&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=30&id=5', '127.0.0.1', 1477124981),
(164, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/activity?snippet=4&caseID=5&cid=30&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=30&id=5', '127.0.0.1', 1477124981),
(165, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/rest?entity=contact&action=getlist&json=%7B%22params%22%3A%7B%7D%2C%22input%22%3A%22omer%22%2C%22page_num%22%3A1%7D&_=1477124988765', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125000),
(166, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=6&cid=34&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=34&id=6', '127.0.0.1', 1477125037),
(167, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=6&cid=34&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=34&id=6', '127.0.0.1', 1477125037),
(168, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/clientrelationships?snippet=4&caseID=7&cid=34&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=34&id=7', '127.0.0.1', 1477125064),
(169, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=7&cid=34&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=34&id=7', '127.0.0.1', 1477125064),
(170, 1, 'rules', 'Cache rebuild lock hit: !cid', 0x613a313a7b733a343a2221636964223b733a31303a226576656e745f696e6974223b7d, 4, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/ajax/globalrelationships?snippet=4&caseID=7&cid=34&userID=202', 'http://127.0.0.1:8001/civicrmTest/civicrm/contact/view/case?reset=1&action=view&cid=34&id=7', '127.0.0.1', 1477125064),
(171, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31373a22556e646566696e656420696e6465783a20223b733a393a222566756e6374696f6e223b733a35333a2243524d5f41637469766974795f42414f5f41637469766974793a3a67657446696c65466f7241637469766974795479706549642829223b733a353a222566696c65223b733a38333a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f41637469766974792f42414f2f41637469766974792e706870223b733a353a22256c696e65223b693a323131333b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125092),
(172, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31373a22556e646566696e656420696e6465783a20223b733a393a222566756e6374696f6e223b733a33323a2243524d5f436173655f466f726d5f436173652d3e70726550726f636573732829223b733a353a222566696c65223b733a37363a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f436173652f466f726d2f436173652e706870223b733a353a22256c696e65223b693a3137313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125092),
(173, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31373a22556e646566696e656420696e6465783a20223b733a393a222566756e6374696f6e223b733a33323a2243524d5f436173655f466f726d5f436173652d3e70726550726f636573732829223b733a353a222566696c65223b733a37363a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f436173652f466f726d2f436173652e706870223b733a353a22256c696e65223b693a3137323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125092),
(174, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31373a22556e646566696e656420696e6465783a20223b733a393a222566756e6374696f6e223b733a33323a2243524d5f436173655f466f726d5f436173652d3e70726550726f636573732829223b733a353a222566696c65223b733a37363a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f436173652f466f726d2f436173652e706870223b733a353a22256c696e65223b693a3137333b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125092),
(175, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31373a22556e646566696e656420696e6465783a20223b733a393a222566756e6374696f6e223b733a35333a2243524d5f41637469766974795f42414f5f41637469766974793a3a67657446696c65466f7241637469766974795479706549642829223b733a353a222566696c65223b733a38333a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f41637469766974792f42414f2f41637469766974792e706870223b733a353a22256c696e65223b693a323131333b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125104),
(176, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31373a22556e646566696e656420696e6465783a20223b733a393a222566756e6374696f6e223b733a33323a2243524d5f436173655f466f726d5f436173652d3e70726550726f636573732829223b733a353a222566696c65223b733a37363a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f436173652f466f726d2f436173652e706870223b733a353a22256c696e65223b693a3137313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125105),
(177, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31373a22556e646566696e656420696e6465783a20223b733a393a222566756e6374696f6e223b733a33323a2243524d5f436173655f466f726d5f436173652d3e70726550726f636573732829223b733a353a222566696c65223b733a37363a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f436173652f466f726d2f436173652e706870223b733a353a22256c696e65223b693a3137323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125105),
(178, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31373a22556e646566696e656420696e6465783a20223b733a393a222566756e6374696f6e223b733a33323a2243524d5f436173655f466f726d5f436173652d3e70726550726f636573732829223b733a353a222566696c65223b733a37363a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f43524d2f436173652f466f726d2f436173652e706870223b733a353a22256c696e65223b693a3137333b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125105),
(179, 1, 'user', 'Session closed for %name.', 0x613a313a7b733a353a22256e616d65223b733a353a2261646d696e223b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/user/logout', 'http://127.0.0.1:8001/civicrmTest/civicrm/case/add?reset=1&action=add&atype=13&context=standalone', '127.0.0.1', 1477125187),
(180, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a37373a2273796e746178206572726f722c20756e65787065637465642026233033393b636c6f6e6526233033393b2028545f434c4f4e45292c20657870656374696e672026233033393b2826233033393b223b733a393a222566756e6374696f6e223b733a31343a22726571756972655f6f6e63652829223b733a353a222566696c65223b733a3130313a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f7061636b616765732f44422f446174614f626a6563742e7068702832303729203a206576616c2829276420636f6465223b733a353a22256c696e65223b693a313b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/index.php', '', '127.0.0.1', 1477125194),
(181, 1, 'user', 'Session opened for %name.', 0x613a313a7b733a353a22256e616d65223b733a353a2261646d696e223b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/node?destination=node', 'http://127.0.0.1:8001/civicrmTest/', '127.0.0.1', 1477125281),
(182, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a37373a2273796e746178206572726f722c20756e65787065637465642026233033393b636c6f6e6526233033393b2028545f434c4f4e45292c20657870656374696e672026233033393b2826233033393b223b733a393a222566756e6374696f6e223b733a31343a22726571756972655f6f6e63652829223b733a353a222566696c65223b733a3130313a222f686f6d652f7765627365727665722f6369766963726d546573742f73697465732f616c6c2f6d6f64756c65732f6369766963726d2f7061636b616765732f44422f446174614f626a6563742e7068702832303729203a206576616c2829276420636f6465223b733a353a22256c696e65223b693a313b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/index.php', '', '127.0.0.1', 1477125286),
(183, 1, 'user', 'Session closed for %name.', 0x613a313a7b733a353a22256e616d65223b733a353a2261646d696e223b7d, 5, '', 'http://127.0.0.1:8001/civicrmTest/user/logout', 'http://127.0.0.1:8001/civicrmTest/node', '127.0.0.1', 1477125306);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actions`
--
ALTER TABLE `actions`
  ADD PRIMARY KEY (`aid`);

--
-- Indexes for table `authmap`
--
ALTER TABLE `authmap`
  ADD PRIMARY KEY (`aid`),
  ADD UNIQUE KEY `authname` (`authname`),
  ADD KEY `uid_module` (`uid`,`module`);

--
-- Indexes for table `batch`
--
ALTER TABLE `batch`
  ADD PRIMARY KEY (`bid`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `block`
--
ALTER TABLE `block`
  ADD PRIMARY KEY (`bid`),
  ADD UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  ADD KEY `list` (`theme`,`status`,`region`,`weight`,`module`);

--
-- Indexes for table `blocked_ips`
--
ALTER TABLE `blocked_ips`
  ADD PRIMARY KEY (`iid`),
  ADD KEY `blocked_ip` (`ip`);

--
-- Indexes for table `block_custom`
--
ALTER TABLE `block_custom`
  ADD PRIMARY KEY (`bid`),
  ADD UNIQUE KEY `info` (`info`);

--
-- Indexes for table `block_node_type`
--
ALTER TABLE `block_node_type`
  ADD PRIMARY KEY (`module`,`delta`,`type`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `block_role`
--
ALTER TABLE `block_role`
  ADD PRIMARY KEY (`module`,`delta`,`rid`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_admin_menu`
--
ALTER TABLE `cache_admin_menu`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_block`
--
ALTER TABLE `cache_block`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_bootstrap`
--
ALTER TABLE `cache_bootstrap`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_entity_og_membership`
--
ALTER TABLE `cache_entity_og_membership`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_entity_og_membership_type`
--
ALTER TABLE `cache_entity_og_membership_type`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_field`
--
ALTER TABLE `cache_field`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_filter`
--
ALTER TABLE `cache_filter`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_form`
--
ALTER TABLE `cache_form`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_image`
--
ALTER TABLE `cache_image`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_menu`
--
ALTER TABLE `cache_menu`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_page`
--
ALTER TABLE `cache_page`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_path`
--
ALTER TABLE `cache_path`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_rules`
--
ALTER TABLE `cache_rules`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `cache_update`
--
ALTER TABLE `cache_update`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `comment_status_pid` (`pid`,`status`),
  ADD KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  ADD KEY `comment_uid` (`uid`),
  ADD KEY `comment_nid_language` (`nid`,`language`),
  ADD KEY `comment_created` (`created`);

--
-- Indexes for table `ctools_css_cache`
--
ALTER TABLE `ctools_css_cache`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `ctools_object_cache`
--
ALTER TABLE `ctools_object_cache`
  ADD PRIMARY KEY (`sid`,`obj`,`name`),
  ADD KEY `updated` (`updated`);

--
-- Indexes for table `date_formats`
--
ALTER TABLE `date_formats`
  ADD PRIMARY KEY (`dfid`),
  ADD UNIQUE KEY `formats` (`format`,`type`);

--
-- Indexes for table `date_format_locale`
--
ALTER TABLE `date_format_locale`
  ADD PRIMARY KEY (`type`,`language`);

--
-- Indexes for table `date_format_type`
--
ALTER TABLE `date_format_type`
  ADD PRIMARY KEY (`type`),
  ADD KEY `title` (`title`);

--
-- Indexes for table `field_config`
--
ALTER TABLE `field_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_name` (`field_name`),
  ADD KEY `active` (`active`),
  ADD KEY `storage_active` (`storage_active`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `module` (`module`),
  ADD KEY `storage_module` (`storage_module`),
  ADD KEY `type` (`type`),
  ADD KEY `storage_type` (`storage_type`);

--
-- Indexes for table `field_config_instance`
--
ALTER TABLE `field_config_instance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  ADD KEY `deleted` (`deleted`);

--
-- Indexes for table `field_data_body`
--
ALTER TABLE `field_data_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `body_format` (`body_format`);

--
-- Indexes for table `field_data_comment_body`
--
ALTER TABLE `field_data_comment_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `comment_body_format` (`comment_body_format`);

--
-- Indexes for table `field_data_field_image`
--
ALTER TABLE `field_data_field_image`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_image_fid` (`field_image_fid`);

--
-- Indexes for table `field_data_field_tags`
--
ALTER TABLE `field_data_field_tags`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_tags_tid` (`field_tags_tid`);

--
-- Indexes for table `field_data_og_membership_request`
--
ALTER TABLE `field_data_og_membership_request`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `og_membership_request_format` (`og_membership_request_format`);

--
-- Indexes for table `field_revision_body`
--
ALTER TABLE `field_revision_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `body_format` (`body_format`);

--
-- Indexes for table `field_revision_comment_body`
--
ALTER TABLE `field_revision_comment_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `comment_body_format` (`comment_body_format`);

--
-- Indexes for table `field_revision_field_image`
--
ALTER TABLE `field_revision_field_image`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_image_fid` (`field_image_fid`);

--
-- Indexes for table `field_revision_field_tags`
--
ALTER TABLE `field_revision_field_tags`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_tags_tid` (`field_tags_tid`);

--
-- Indexes for table `field_revision_og_membership_request`
--
ALTER TABLE `field_revision_og_membership_request`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `og_membership_request_format` (`og_membership_request_format`);

--
-- Indexes for table `file_managed`
--
ALTER TABLE `file_managed`
  ADD PRIMARY KEY (`fid`),
  ADD UNIQUE KEY `uri` (`uri`),
  ADD KEY `uid` (`uid`),
  ADD KEY `status` (`status`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Indexes for table `file_usage`
--
ALTER TABLE `file_usage`
  ADD PRIMARY KEY (`fid`,`type`,`id`,`module`),
  ADD KEY `type_id` (`type`,`id`),
  ADD KEY `fid_count` (`fid`,`count`),
  ADD KEY `fid_module` (`fid`,`module`);

--
-- Indexes for table `filter`
--
ALTER TABLE `filter`
  ADD PRIMARY KEY (`format`,`name`),
  ADD KEY `list` (`weight`,`module`,`name`);

--
-- Indexes for table `filter_format`
--
ALTER TABLE `filter_format`
  ADD PRIMARY KEY (`format`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `status_weight` (`status`,`weight`);

--
-- Indexes for table `flood`
--
ALTER TABLE `flood`
  ADD PRIMARY KEY (`fid`),
  ADD KEY `allow` (`event`,`identifier`,`timestamp`),
  ADD KEY `purge` (`expiration`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`uid`,`nid`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `image_effects`
--
ALTER TABLE `image_effects`
  ADD PRIMARY KEY (`ieid`),
  ADD KEY `isid` (`isid`),
  ADD KEY `weight` (`weight`);

--
-- Indexes for table `image_styles`
--
ALTER TABLE `image_styles`
  ADD PRIMARY KEY (`isid`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `menu_custom`
--
ALTER TABLE `menu_custom`
  ADD PRIMARY KEY (`menu_name`);

--
-- Indexes for table `menu_links`
--
ALTER TABLE `menu_links`
  ADD PRIMARY KEY (`mlid`),
  ADD KEY `path_menu` (`link_path`(128),`menu_name`),
  ADD KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  ADD KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  ADD KEY `router_path` (`router_path`(128));

--
-- Indexes for table `menu_router`
--
ALTER TABLE `menu_router`
  ADD PRIMARY KEY (`path`),
  ADD KEY `fit` (`fit`),
  ADD KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  ADD KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`);

--
-- Indexes for table `node`
--
ALTER TABLE `node`
  ADD PRIMARY KEY (`nid`),
  ADD UNIQUE KEY `vid` (`vid`),
  ADD KEY `node_changed` (`changed`),
  ADD KEY `node_created` (`created`),
  ADD KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  ADD KEY `node_status_type` (`status`,`type`,`nid`),
  ADD KEY `node_title_type` (`title`,`type`(4)),
  ADD KEY `node_type` (`type`(4)),
  ADD KEY `uid` (`uid`),
  ADD KEY `tnid` (`tnid`),
  ADD KEY `translate` (`translate`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `node_access`
--
ALTER TABLE `node_access`
  ADD PRIMARY KEY (`nid`,`gid`,`realm`);

--
-- Indexes for table `node_comment_statistics`
--
ALTER TABLE `node_comment_statistics`
  ADD PRIMARY KEY (`nid`),
  ADD KEY `node_comment_timestamp` (`last_comment_timestamp`),
  ADD KEY `comment_count` (`comment_count`),
  ADD KEY `last_comment_uid` (`last_comment_uid`);

--
-- Indexes for table `node_revision`
--
ALTER TABLE `node_revision`
  ADD PRIMARY KEY (`vid`),
  ADD KEY `nid` (`nid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `node_type`
--
ALTER TABLE `node_type`
  ADD PRIMARY KEY (`type`);

--
-- Indexes for table `og_membership`
--
ALTER TABLE `og_membership`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entity` (`etid`,`entity_type`),
  ADD KEY `group` (`gid`,`group_type`),
  ADD KEY `group_type` (`group_type`);

--
-- Indexes for table `og_membership_type`
--
ALTER TABLE `og_membership_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `og_role`
--
ALTER TABLE `og_role`
  ADD PRIMARY KEY (`rid`);

--
-- Indexes for table `og_role_permission`
--
ALTER TABLE `og_role_permission`
  ADD PRIMARY KEY (`rid`,`permission`),
  ADD KEY `permission` (`permission`);

--
-- Indexes for table `og_users_roles`
--
ALTER TABLE `og_users_roles`
  ADD PRIMARY KEY (`uid`,`rid`,`gid`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `queue`
--
ALTER TABLE `queue`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `name_created` (`name`,`created`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `rdf_mapping`
--
ALTER TABLE `rdf_mapping`
  ADD PRIMARY KEY (`type`,`bundle`);

--
-- Indexes for table `registry`
--
ALTER TABLE `registry`
  ADD PRIMARY KEY (`name`,`type`),
  ADD KEY `hook` (`type`,`weight`,`module`);

--
-- Indexes for table `registry_file`
--
ALTER TABLE `registry_file`
  ADD PRIMARY KEY (`filename`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`rid`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `name_weight` (`name`,`weight`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`rid`,`permission`),
  ADD KEY `permission` (`permission`);

--
-- Indexes for table `rules_config`
--
ALTER TABLE `rules_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `plugin` (`plugin`);

--
-- Indexes for table `rules_dependencies`
--
ALTER TABLE `rules_dependencies`
  ADD PRIMARY KEY (`id`,`module`),
  ADD KEY `module` (`module`);

--
-- Indexes for table `rules_tags`
--
ALTER TABLE `rules_tags`
  ADD PRIMARY KEY (`id`,`tag`);

--
-- Indexes for table `rules_trigger`
--
ALTER TABLE `rules_trigger`
  ADD PRIMARY KEY (`id`,`event`);

--
-- Indexes for table `search_dataset`
--
ALTER TABLE `search_dataset`
  ADD PRIMARY KEY (`sid`,`type`);

--
-- Indexes for table `search_index`
--
ALTER TABLE `search_index`
  ADD PRIMARY KEY (`word`,`sid`,`type`),
  ADD KEY `sid_type` (`sid`,`type`);

--
-- Indexes for table `search_node_links`
--
ALTER TABLE `search_node_links`
  ADD PRIMARY KEY (`sid`,`type`,`nid`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `search_total`
--
ALTER TABLE `search_total`
  ADD PRIMARY KEY (`word`);

--
-- Indexes for table `semaphore`
--
ALTER TABLE `semaphore`
  ADD PRIMARY KEY (`name`),
  ADD KEY `value` (`value`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `sequences`
--
ALTER TABLE `sequences`
  ADD PRIMARY KEY (`value`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sid`,`ssid`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `uid` (`uid`),
  ADD KEY `ssid` (`ssid`);

--
-- Indexes for table `shortcut_set`
--
ALTER TABLE `shortcut_set`
  ADD PRIMARY KEY (`set_name`);

--
-- Indexes for table `shortcut_set_users`
--
ALTER TABLE `shortcut_set_users`
  ADD PRIMARY KEY (`uid`),
  ADD KEY `set_name` (`set_name`);

--
-- Indexes for table `system`
--
ALTER TABLE `system`
  ADD PRIMARY KEY (`filename`),
  ADD KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  ADD KEY `type_name` (`type`,`name`);

--
-- Indexes for table `taxonomy_index`
--
ALTER TABLE `taxonomy_index`
  ADD KEY `term_node` (`tid`,`sticky`,`created`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `taxonomy_term_data`
--
ALTER TABLE `taxonomy_term_data`
  ADD PRIMARY KEY (`tid`),
  ADD KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  ADD KEY `vid_name` (`vid`,`name`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `taxonomy_term_hierarchy`
--
ALTER TABLE `taxonomy_term_hierarchy`
  ADD PRIMARY KEY (`tid`,`parent`),
  ADD KEY `parent` (`parent`);

--
-- Indexes for table `taxonomy_vocabulary`
--
ALTER TABLE `taxonomy_vocabulary`
  ADD PRIMARY KEY (`vid`),
  ADD UNIQUE KEY `machine_name` (`machine_name`),
  ADD KEY `list` (`weight`,`name`);

--
-- Indexes for table `url_alias`
--
ALTER TABLE `url_alias`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `alias_language_pid` (`alias`,`language`,`pid`),
  ADD KEY `source_language_pid` (`source`,`language`,`pid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `access` (`access`),
  ADD KEY `created` (`created`),
  ADD KEY `mail` (`mail`),
  ADD KEY `picture` (`picture`);

--
-- Indexes for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD PRIMARY KEY (`uid`,`rid`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `variable`
--
ALTER TABLE `variable`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `watchdog`
--
ALTER TABLE `watchdog`
  ADD PRIMARY KEY (`wid`),
  ADD KEY `type` (`type`),
  ADD KEY `uid` (`uid`),
  ADD KEY `severity` (`severity`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authmap`
--
ALTER TABLE `authmap`
  MODIFY `aid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.';
--
-- AUTO_INCREMENT for table `block`
--
ALTER TABLE `block`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.', AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `blocked_ips`
--
ALTER TABLE `blocked_ips`
  MODIFY `iid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.';
--
-- AUTO_INCREMENT for table `block_custom`
--
ALTER TABLE `block_custom`
  MODIFY `bid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.';
--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.';
--
-- AUTO_INCREMENT for table `date_formats`
--
ALTER TABLE `date_formats`
  MODIFY `dfid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.', AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT for table `field_config`
--
ALTER TABLE `field_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field', AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `field_config_instance`
--
ALTER TABLE `field_config_instance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance', AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `file_managed`
--
ALTER TABLE `file_managed`
  MODIFY `fid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'File ID.';
--
-- AUTO_INCREMENT for table `flood`
--
ALTER TABLE `flood`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.';
--
-- AUTO_INCREMENT for table `image_effects`
--
ALTER TABLE `image_effects`
  MODIFY `ieid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.';
--
-- AUTO_INCREMENT for table `image_styles`
--
ALTER TABLE `image_styles`
  MODIFY `isid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.';
--
-- AUTO_INCREMENT for table `menu_links`
--
ALTER TABLE `menu_links`
  MODIFY `mlid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.', AUTO_INCREMENT=386;
--
-- AUTO_INCREMENT for table `node`
--
ALTER TABLE `node`
  MODIFY `nid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.';
--
-- AUTO_INCREMENT for table `node_revision`
--
ALTER TABLE `node_revision`
  MODIFY `vid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.';
--
-- AUTO_INCREMENT for table `og_membership`
--
ALTER TABLE `og_membership`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The group membership’s unique ID.';
--
-- AUTO_INCREMENT for table `og_membership_type`
--
ALTER TABLE `og_membership_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Numeric group membership type ID.', AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `og_role`
--
ALTER TABLE `og_role`
  MODIFY `rid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.';
--
-- AUTO_INCREMENT for table `queue`
--
ALTER TABLE `queue`
  MODIFY `item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.', AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `rid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.', AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `rules_config`
--
ALTER TABLE `rules_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal identifier for any configuration.', AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sequences`
--
ALTER TABLE `sequences`
  MODIFY `value` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.', AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `taxonomy_term_data`
--
ALTER TABLE `taxonomy_term_data`
  MODIFY `tid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.';
--
-- AUTO_INCREMENT for table `taxonomy_vocabulary`
--
ALTER TABLE `taxonomy_vocabulary`
  MODIFY `vid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.', AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `url_alias`
--
ALTER TABLE `url_alias`
  MODIFY `pid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.';
--
-- AUTO_INCREMENT for table `watchdog`
--
ALTER TABLE `watchdog`
  MODIFY `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.', AUTO_INCREMENT=184;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
